using afPlastic::SrcCodeSnippet

** Provides meta data about an efan template.
** 
** @see `EfanRenderer.efanMetaData`
const class EfanMetaData {

	** The compiled efan type.
	const Type type

	** The generated fantom code (for the inquisitive).
	const Str typeSrc

	** A unique ID for the template. Defaults to the fully qualified type name.
	const Str templateId
	
	** Where the template originated from. Example, 'file://layout.efan'. 
	const Uri templateLoc

	** The original efan template.
	const Str template
	
	// ctx variables used by BedSheetEfan and Genesis - they recompile the template if they change.
	
	** The 'ctx' type the renderer was compiled against.
	const Type? ctxType

	** The name of the 'ctx' variable the renderer was compiled with. 
	** Returns 'null' if a ctx variable was not used.
	const Str? ctxName
	
	internal const Int srcCodePadding

	@NoDoc
	new make(|This|? in := null) {
		in?.call(this)
		if (null == this.type)			this.type			= Void#
		if (null == this.typeSrc)		this.typeSrc		= ""
		if (null == this.templateId)	this.templateId		= Int.random.toStr
		if (null == this.templateLoc)	this.templateLoc	= `wherever`
		if (null == this.template)		this.template		= ""
	}

	internal Void throwCompilationErr(Err cause, Int srcCodeLineNo) {
		templateLineNo	:= findTemplateLineNo(srcCodeLineNo) ?: throw cause
		srcCodeSnippet	:= SrcCodeSnippet(templateLoc, template)
		throw EfanCompilationErr(srcCodeSnippet, templateLineNo, cause.msg, srcCodePadding, cause)
	}
	
	internal Void throwRuntimeErr(Err cause, Int srcCodeLineNo) {
		templateLineNo	:= findTemplateLineNo(srcCodeLineNo) ?: throw cause
		srcCodeSnippet	:= SrcCodeSnippet(templateLoc, template)
		throw EfanRuntimeErr(srcCodeSnippet, templateLineNo, cause.msg, srcCodePadding, cause)
	}
	
	private Int? findTemplateLineNo(Int srcCodeLineNo) {
		fanLineNo		:= srcCodeLineNo - 1	// from 1 to 0 based
		reggy 			:= Regex<|\s+?// \(efan\) --> ([0-9]+)$|>
		efanLineNo		:= (Int?) null
		fanCodeLines	:= typeSrc.splitLines
		
		while (fanLineNo > 0 && efanLineNo == null) {
			code := fanCodeLines[fanLineNo]
			reg := reggy.matcher(code)
			if (reg.find) {
				efanLineNo = reg.group(1).toInt
			} else {
				fanLineNo--
			}
		}
		
		return efanLineNo
	}
	
	** Clones this object, setting the given values.
	EfanMetaData clone([Field:Obj?]? overrides := null) {
		Utils.cloneObj(this) |[Field:Obj?] plan| { plan.setAll(overrides) }
	}
}
