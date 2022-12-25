function final!(robot)
    while try_move!(robot,Nord)
    end
    shatl!(r->!isborder(robot,Nord), robot)
end

function try_move!(robot,side)
    if isborder(robot,side)
        return false
    else 
        move!(robot,side)
        return true
    end
end
function  shatl!(stop_condition::Function, robot)
    n=0 # число шагов от начального положения
    side=Ost
    while !stop_condition(side) 
        n += 1
        along!(robot, side, n)
        side = inverse_side(side)
    end
end
function along!(robot, side, max_num_steps)::Int
    num_steps = 0
    while num_steps < max_num_steps && try_move!(robot, side) # - в этом логическом выражении порядок аргументов важен!
        num_steps += 1
    end  
    return num_steps 
end

function along!(stop_condition::Function, robot, side) 
    n=0
    while !stop_condition(robot)
        move!(robot, side)
        n += 1
    end
    return n
end

function inverse_side(side::HorizonSide)::HorizonSide
    inv_side = HorizonSide((Int(side) + 2) % 4)
    return inv_side
end

final!(r)