function final!(robot, side)
    if isborder(robot, side)
        while !isborder(robot, inverse(side))
            move!(robot, inverse(side))
        end
    else
        move!(robot, side)
        final!(robot, side)
        move!(robot, side)
    end
end

side = readline()
side = parse(Int64, side)

final!(robot, HorizonSide(side))