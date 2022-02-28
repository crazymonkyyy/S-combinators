import basic;
auto identiy(T)(T a){
	return a+0;
}

unittest{
	//[-3,2,-1,4,-5].scombinator!(a=>a*a).array.sort.map!(a=>a+0).writeln;
	[-3,2,-1,4,-5][].schwartzSort!(a=>a*a).writeln;
	//"aZzA,Hello, World".scombinator!toLower.array.sort.map!(a=>a.unpack).writeln;
	//iota(1,10).scombinator!(iota)(10).map!((a){a.writeln; return a;}).map!(a=>a.unpack).writeln;
	//"hi,foo,(bar,faz,bye),hello,((world))"
	//	.scombinator!(cumulativeFold!(
	//		a=>
	//			a+
	//			(a.me=='(')*-1+
	//			(a.me==')')*1
	//	))
}