function putmarkers_until_border!(r, side)
    n_steps = 0
    while !isborder(r, side) 
        move!(r, side)
        putmarker!(r)
        n_steps += 1
    end 
    return n_steps
end

function inverse_side(side::HorizonSide)::HorizonSide
    inv_side = HorizonSide((Int(side) + 2) % 4)
    return inv_side
end

function zdvig_kuda!(r, Side)
    n=0
    while !isborder(r, Side)
        move!(r, Side)
        n+=1
    end
    return n
end

function steps!(r, Side, p)
    for i in 1:p
        move!(r, Side)
    end
end 

function final!(r)
    steps_sud=zdvig_kuda!(r, Sud)
    steps_West=zdvig_kuda!(r, West)
    n_nord=zdvig_kuda!(r, Nord)
    n_ost=zdvig_kuda!(r, Ost)
    steps!(r, Sud, n_nord//2)
    putmarker!(r)
    for side in (West, Sud)
        putmarkers_until_border!(r, side)
        if side==West
            steps!(r, Nord, n_nord//2)
            steps!(r, Ost, n_ost//2)
            putmarker!(r)
        end
    end
    zdvig_kuda!(r, West)
    steps!(r, Nord, steps_sud)
    steps!(r, Ost, steps_West)
end

final!(r)