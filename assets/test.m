#!/Users/billw/Applications/MacOSX-x86-64-13.3.0.0-8661523-2023.06.03.20016-Release.app/Contents/MacOS/WolframScript -script

manifest = Select[FileNames["*.jpg", "/Users/billw/Dropbox/projects/Findlay-Enterprise/enterprise/1983", Infinity], StringContainsQ[#, "/images/"]&];

Print["manifest contains "<>ToString[Length[manifest]]<>" file"];

AbsoluteTiming[
Module[{f, i, t, outfile},
	f = #;
	outfile = StringReplace[f, ".jpg"~~EndOfString -> ".txt"];
	Print[outfile];
	i = ImageResize[Import[f], Scaled[2]];
	t = TextRecognize[i, Language -> {"English"}];
	Export[outfile, ToString[t, TextForm], "Lines"]
]& /@ manifest;
]
