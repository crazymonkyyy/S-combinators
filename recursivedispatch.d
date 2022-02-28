struct a{
	b tob(){return b();}
	bool isa(){return true;}
}
struct b{
	a toa(){return a();}
	bool isa(){return false;}
}
struct foo{
	int i;
	a toa(){ return a();}
}
struct godhelpme(T,S...){
	T me;
	static if(S.length==1){
		auto get(){ 
			mixin("return me."~S[0]~";");
		}
	} else {
		auto get(){ 
			alias unwrap=godhelpme!(T,S[1..$]);
			mixin("return unwrap(me).get."~S[0]~";");
		}
	}
	auto opDispatch(string name)(){
		alias wrap=godhelpme!(T,name,S);
		return wrap(me);
	}
}
auto bar(foo a){
	return godhelpme!(foo,"toa")(a);
}
import basic;
unittest{
	foo[] foos=[foo(1),foo(2),foo(3)];
	foos
		.map!bar
		//.map!(a=>a.toa)
		.map!(a=>a.tob)
		.map!(a=>a.toa)
		.map!(a=>a.tob)
		.map!(a=>a.toa)
		.map!(a=>a.tob)
		.map!(a=>a.toa)
		.map!(a=>a.tob)
		.map!(a=>a.toa)
		.map!(a=>a.tob)
		.map!(a=>a.toa)
		.map!(a=>a.tob)
		.map!(a=>a.toa)
		.map!(a=>a.me)
		.writeln;
}
template filtermetadata(int i,A...){
	//pragma(msg,i);
	//pragma(msg,A);
	static if(i<A.length){
		alias acc=A[0..i];
		enum int n=A[i+1];
		alias filtermetadata=
			filtermetadata!(i+n,acc,A[i+2..$]);
	}else{
		alias filtermetadata=A;
	}
}
unittest{
	//pragma(msg,filtermetadata!(0,bar,1,int,bar,2,int,bool,bar,3,int,bool,float));
}
static int add(T...)(int i,T j){
	static foreach(n,e;T){
		i+=j[n];
	}
	return i;
}
float add(float a,float b){return float();}
//static int add(int i,int[] j...){
//	foreach(e;j){
//		i+=e;
//	}
//	return i;
//}
struct lazyvalue(T,A...){
	T me;
	//pragma(msg,A);
	filtermetadata!(0,A) args;
	static if(A.length==0){
		auto get(){ return me;}
	}else{
		static if(A[1]+2==A.length){
			auto get(){
				typeof(args)[$-A[1]..$] args_=args[$-A[1]..$];
				mixin("return "~A[0]~"(me,args_);");
			}
		}else{
			auto get(){ 
				alias unwrap=lazyvalue!(T,A[A[1]+2..$]);
				typeof(args)[$-A[1]..$] args_=args[$-A[1]..$];
				mixin("return "~A[0]~"(unwrap(me,args[0..$-A[1]]).get,args_);");
			}
		}
	}
	auto opDispatch(string name,S...)(S args_){
		//alias F=mixin(name);
		alias wrap=lazyvalue!(T,A,name,S.length,S);
		return wrap(me,args,args_);
	}
	string toString(){
		return get.to!string;
	}
	//this(T a){
	//	me=a;
	//}
}
unittest{
	lazyvalue!int i;
	i.me=2;

	auto j=i.
		add(1,2,3)
		.add(1,2)
		.add(1);
	j.writeln;
	j.me.writeln;
}