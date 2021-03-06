using afPlastic::PlasticCompiler

abstract internal class EfanTest : Test {
	
	EfanCompiler	compiler	:= EfanCompiler()
//	EfanCompiler	compiler	:= EfanCompiler(EfanEngine(PlasticCompiler() { it.srcCodePadding = 50 }))
//	EfanEngine		engine		:= compiler.engine
	EfanParser		parser		:= EfanParser()
	Efan			efan		:= Efan()
	
	Void verifyEfanErrMsg(Str errMsg, |Obj| func) {
		verifyErrTypeMsg(EfanErr#, errMsg, func)
	}

	protected Void verifyErrTypeMsg(Type errType, Str errMsg, |Obj| func) {
		try {
			func(69)
		} catch (Err e) {
			if (!e.typeof.fits(errType)) 
				throw Err("Expected $errType got $e.typeof", e)
			msg := e.msg
			if (msg != errMsg)
				verifyEq(errMsg, msg)	// this gives the Str comparator in eclipse
//				throw Err("Expected: \n - $errMsg \nGot: \n - $msg")
			return
		}
		throw Err("$errType not thrown")
	}
	
}
