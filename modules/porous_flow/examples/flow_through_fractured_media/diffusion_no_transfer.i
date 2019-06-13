[Mesh]
  file = 1_frac_in_2D_lower_dim.e # 1_frac_in_2D_lower_dim_fine.e, 1_frac_in_2D_lower_dim_log_matrix.e
[]

[Variables]
  [./T]
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
    variable = T
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


