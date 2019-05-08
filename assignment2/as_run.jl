using JuMP
#using Cbc
using Gurobi
using SparseArrays

T = 4
include("as_dat_small.jl")
include("as_mod.jl")
m, x, z = build_model()
# add_cut_to_small(m)
setsolver(m, GurobiSolver())
#setsolver(m, GurobiSolver(MIPGap = 2e-2, TimeLimit = 3600))
#setsolver(m, CbcSolver(logLevel = 1, ratioGap = 2e-2)) # if you use Cbc instead of Gurobi
"""
Some useful parameters for the Gurobi solver:
    SolutionLimit = k : the search is terminated after k feasible solutions has been found
    MIPGap = r : the search is terminated when  | best node - best integer | < r * | best node |
    MIPGapAbs = r : the search is terminated when  | best node - best integer | < r
    TimeLimit = t : limits the total time expended to t seconds
    DisplayInterval = t : log lines are printed every t seconds
See http://www.gurobi.com/documentation/8.1/refman/parameters.html for a
complete list of valid parameters
"""

solve(m)


"""
Some useful output & functions
"""
# obj_ip = getobjectivevalue(m)
# obj_lp = m.objVal
# println("obj_ip = $obj_ip, obj_lp = $obj_lp, gap = $(obj_ip-obj_lp) ")

# println(getsolvetime(m))

# x_val = sparse(getvalue(x).innerArray)
# z_val = sparse(getvalue(z))

#println("x  = ")
#println(x_val)
#println("z = ")
#println(z_val)

#solve(m, relaxation=true)

#add_cut_to_small(m)
