using JuMP
#using Cbc
using Gurobi
using SparseArrays

include("as_dat_large.jl")
include("as_mod.jl")

result = Array{Float64}(undef, 16, 2)

i = 0
T = 50

while i < 16
    global i += 1
    global T = 50 + i * 10

    m, x, z = build_model()
    # add_cut_to_small(m)
    setsolver(m, GurobiSolver())

    avg = 0
    j = 0

    while j < 10
        solve(m)
        println(getsolvetime(m))
        avg += getsolvetime(m)
        j += 1
    end

    avg /= 10
    global result[i+1, 1] = 50 + i * 10
    global result[i+1, 2] = avg
end

println(result)




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



"""
Some useful output & functions
"""
# obj_ip = getobjectivevalue(m)
# obj_lp = m.objVal
# println("obj_ip = $obj_ip, obj_lp = $obj_lp, gap = $(obj_ip-obj_lp) ")


# x_val = sparse(getvalue(x).innerArray)
# z_val = sparse(getvalue(z))

#println("x  = ")
#println(x_val)
#println("z = ")
#println(z_val)

#solve(m, relaxation=true)

#add_cut_to_small(m)
