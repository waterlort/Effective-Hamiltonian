

# Effective-Hamiltonian
Demonstration of calculating effective Hamiltonian at the vicinity of a special ground state of Kitaev Spin Liquid Model

The idea is at the ground state when some of the check operators are dominant, the effective Hamiltonian would have form $H_{eff} = \sum_p a_p W_p $, where $W_p$ is essentially the plaquette operator, product of check operators along the border of plaquette p. The $a_p$ is the coeffecient of $W_p$, with certain order of small parameter $\lambda$. This code is for calculating $a_p$, we call it the geometric factor.

So, to use this code to calculate $a_p$, run it, and answer some questions. 
1. the number of check operators on the border of this plaquette
2. Indicate all check operators that are perturbation terms, seperated by commas. Label the check operators by natural numbers, and input their labels. 
3. Is any defect in the plaquette? Input them if any.
And you will get the coeffecient!
