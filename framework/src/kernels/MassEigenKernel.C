//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "MassEigenKernel.h"

registerMooseObject("MooseApp", MassEigenKernel);

template <>
InputParameters
validParams<MassEigenKernel>()
{
  InputParameters params = validParams<EigenKernel>();
  params.addClassDescription("An eigenkernel with weak form $\\lambda(\\psi_i, -u_h)$ where "
                             "$\\lambda$ is the eigenvalue.");
  return params;
}

MassEigenKernel::MassEigenKernel(const InputParameters & parameters) : EigenKernel(parameters) {}

Real
MassEigenKernel::computeQpResidual()
{
  return -_u[_qp] * _test[_i][_qp];
}

Real
MassEigenKernel::computeQpJacobian()
{
  return -_phi[_j][_qp] * _test[_i][_qp];
}
