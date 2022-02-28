import basic;//todo
import scombinators;

//seperate string into by endline and 80 chars
unittest{
	string file=import("scombinators.d");
	file[]
		.map!(a=>a)
		.s_split!((dchar c,ref i){
			if(c=='\n'){i=80;}
			if(i==80){
				i=0;
				return true;
			}
			i++;
			return false;
		})(0)
		.each!writeln;
}
// seperate by top level comma
unittest{
	"foo,bar(1,2),foobar(foo,bar(1,2)),(,,,)"
		.map!(a=>a)
		.s_split!((dchar c,ref parn){
			if(c=='(')parn++;
			if(c==')')parn--;
			return c==','&&parn==0;
		})(0)
		.each!writeln;
}

// prefixsum adding a recuring gap
unittest{
	[1,2,3,4,5][]
		.map!(a=>a)
		.sfoldmap!((a,ref b,g){
			b=a+b+g;
			return b-a;
		})(0,1)
		.writeln;
}

//https://www.spoj.com/problems/ACODE/
unittest{
	ulong fact(ulong i){
		int f(int i, int a, int b){
			if(i<0){return a;}
			return f(i-1,a+b,a);
		}
		return f(cast(int)i,1,1);
	}
	ulong alphacode(string s){
		s~=' ';
		return s
			.map!(a=>a)
			.s_split!((dchar c,ref dchar d){
				if(c==' '){return true;}
				if(c=='0'){
					d=c;
					return true;
				}
				if(d=='1'){
					d=c;
					return false;
				}
				if(d=='2'){
					d=c;
					int i=c.to!int-'0'.to!int;
					if(i<7){
						return false;
				}}
				d=c;
				return true;
			})(dchar(' '))
			.map!(a=>a.array.length)
			.map!(a=>fact(a-1))
			.reduce!((a,b)=>a*b);
	}
	alphacode("25114").writeln;
}
//sort by the squares without modifing the orginal values
unittest{
	[-3,2,-1,4,5].s_sort!(a=>a*a).writeln;
}
//spilt by a list of indexs
unittest{
	iota(0,100).
		s_split!((a,ref i,ref indexs){
			i++;
			if(indexs.length==0){return false;}
			if(indexs[0]==i){
				indexs=indexs[1..$];
				return true;
			}
			return false;
		})(-1,[10,25,50])
		.writeln;
}
//prefix mean
unittest{
	[10,2,3,4,1,4,34,12,3,5]
		.map!(a=>a)
		.sfoldmap!((a,ref total,ref count){
			total+=a;
			count++;
			return total/count;
		})(0,0)
		.writeln;
}
//double an int as a string
unittest{
	"8957634089265789632078986507893246453078 "
		.map!(a=>a)
		.sfoldmap!((c,ref d){
			if(c>'4'){
				d++;
				c-=5;
			}
			dchar temp=d;
			d=(c-'0')*2+'0';
			return temp;
		})(dchar('0'))
		.writeln;
}
//unqi mantaining order 
unittest{
	bool[int] has;
	[1,2,3,4,123,2343,23,3,25,231,13,1213,23,31,2,31,23,12,2,4,32,3,31,3,24,32,2,34,32,1,34,23,4,2,22,2,2,2,2,2323,3,2,321,1324]
		.map!(a=>a)
		.sfoldmap!((int a,ref bool[int] store){//todo write sfilter
			if(a in store){ return -1;}
			store[a]=true;
			return a;
		})(has)
		.filter!(a=>a!=-1)
		.writeln;
	has.writeln;
}