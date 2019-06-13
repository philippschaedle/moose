[Mesh]
  file = 1_frac_in_2D_lower_dim.e # 1_frac_in_2D_lower_dim_fine.e, 1_frac_in_2D_lower_dim_log_matrix.e
[]

[Variables]
  [./T]
    block = 1
  [../]
  [./T_matrix]
  [../]
[]

[BCs]
  [./left]
    type = PresetBC
    boundary = 2
    variable = T
    value = 1
  [../]
[]

[Kernels]
  [./dot]
    type = TimeDerivative
    variable = T
    block = 1
  [../]
  [./dot_matrix]
    type = TimeDerivative
    variable = T_matrix
    block = '2 3'
  [../]
  [./fracture_diffusion]
    type = AnisotropicDiffusion
    block = 1
    tensor_coeff = '1e-2 0 0  0 1e-2 0  0 0 1e-2'
    variable = T
  [../]
  [./matrix_diffusion]
    type = AnisotropicDiffusion
    block = '2 3'
    tensor_coeff = '1e-8 0 0  0 1e-8 0  0 0 1e-8'
    variable = T_matrix
  [../]
  [./value_transfer1]
    type = PorousFlowHeatMassTransfer
    variable = T
    v = T_matrix
    transfer_coefficient = 2e-6 # (km*kf)/(km*lm+kf*lf)
    block = 1
  [../]
  [./value_transfer2]
    type = PorousFlowHeatMassTransfer
    variable = T_matrix
    v = T
    transfer_coefficient = 2e-6
    block = 1
  [../]
[]

[VectorPostprocessors]
  [./line_sample_T]
    type = LineValueSampler
    variable = T
    start_point = '-5 0 0'
    end_point = '5 0 0'
    num_points = 100
    sort_by = id
  [../]
[]

[Preconditioning]
  [./entire_jacobian]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  dt = 10
  end_time = 300
  nl_abs_tol = 1E-13
  nl_rel_tol = 1E-12
[]

[Outputs]
  print_linear_residuals = false
  csv = true
  execute_on = FINAL
[]


