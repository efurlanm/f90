implicit none
integer, pointer :: point
integer, target :: targ
targ = 3
point => targ
print*, point, targ
end
