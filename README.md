## q
q is the most useless language in the world. it's only purpose it to self host itself. q only has one instruction, q, which instructs the compiler to print its own source code.  

credit to tsoding: https://www.youtube.com/watch?v=QGm-d5Ch5JM  

there are a couple implementation differences, I chose to use Zig's multiline strings and rather than look for q in the nested "self" loop I look for the string of q (" + q + ") which is sort of hacky but made implementation much simpler. 

to run:
```
zig build run -- q.q
```
or
```
zig build
./zig-out/bin/quine q.q
```
