<!-- #include file="../../../SCargoConn.asp"-->
<%
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
'Set dosprint = Server.CreateObject("DOS_Print.clsPrint")
Dim objFSO, objTStream
MRSNO=Request.QueryString("MRSNO")
dockno=Request.QueryString("dockno")
PrintFileName="print_folder\" & MRSNO & ".txt"
'PrintFileName="doc.txt"
'Response.Write PrintFileName
'Response.Write server.MapPath(PrintFileName)
Set objTStream = objFSO.OpenTextFile(server.MapPath(PrintFileName), 1)

Do Until objTStream.AtEndOfStream
	'if FileData="" then
	'		FileData= "objPrint.Print_Line('" + replace(replace(objTStream.ReadLine,chr(32)," "),chr(13),"\n") +"');"
	'else
	'		FileData= FileData + "objPrint.Print_Line('" + replace(replace(objTStream.ReadLine,chr(32)," "),chr(13),"\n") +"');" 
	'end if
	CurrLineData=objTStream.ReadLine
	if FileData="" then
			FileData=  replace(replace(replace(CurrLineData,chr(32)," "),chr(13),"\n") ,"'","''")
	else
			FileData= FileData + "\n" + replace(replace(replace(CurrLineData,chr(32)," "),chr(13),"\n") ,"'","''") 
	end if
		
	if oriFileData="" then 
		oriFileData= CurrLineData
	else
		oriFileData= oriFileData + CurrLineData 
	end if
	
Loop
'oriFileData=FileData
if FileData<>"" then
	FileData= "objPrint.Print_Line('" + FileData  +"');"
end if

objTStream.Close

Set objTStream = nothing
Set objFSO = nothing

%>
<!--<object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"    codebase="http://202.87.45.70/print_utility/webx_dos_print.cab#version=1,0,0,0"></object>-->
<object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"     codebase="http://202.87.45.70/irtl/print_utility/webx_dos_print.cab#version=1,0,0,0"></object>

<script language="Javascript">

function print_click()
{	
	<%
		Response.write  FileData
	%>
	//alert("Printing done!!!")
	window.close();
}
//onload="print_click"
</script>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
<LINK title=stylesheet href="../../../images/style_print.css" type=text/css rel=stylesheet>
</HEAD>
<BODY  onload="javascript:print_click()">
<form name="frm"  >
<%
dockno=Request.QueryString("dockno")
typ="4"
%>
<!-- #include file="../end_time.asp"-->
<%
'Set objTStream = objFSO.OpenTextFile(server.MapPath(PrintFileName), 1)
'Do Until objTStream.AtEndOfStream
'	CurrLineData=replace(objTStream.ReadLine,chr(10)," ")
'	Response.Write CurrLineData + "<br>"
'Loop
'objTStream.Close
'Set objTStream = nothing
'Response.Redirect Request.QueryString("docno") & ".txt"
%>
</form>
</BODY>
</HTML>