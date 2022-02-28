import basic;
int add3(int i){return i+3;}
struct break_(T,int i){
	T old;
	T me;
	static if(i>0){
		auto opDispatch(string name,T...)(T vals){
			alias S=typeof(mixin(name~"(me,vals)"));
			alias O=break_!(S,i-1);
			mixin("return O(old,"~name~"(me,vals));");
		}
		string toString(){
			return me.to!string;
		}
	}else{
		auto get(){
			return old;
		}
		alias get this;
	}
}
unittest{
	break_!(int,3) foo;
	//foo.opDispatch!("opBinary","+",int)(3).writeln;
	//foo+3+3+3.writeln;
	
	foo.add3.add3.add3.writeln;
}