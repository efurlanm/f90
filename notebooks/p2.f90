implicit none
integer, pointer :: point
integer, target :: targ
point => targ
point = 3
print*, point, targ
end
