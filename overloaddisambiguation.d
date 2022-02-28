void foo(){}
void foo(int i){}
void foo(float f){}

unittest{
	alias over=__traits(getOverloads,mixin(__MODULE__),"foo");
	over[0]();
	over[1](1);
	over[2](1.2);
}