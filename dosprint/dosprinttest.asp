<%@ Language=VBScript %>
<%
Response.Write "Hi 11111111111"
FileData = "TEST"
FileData= "objPrint.Print_Line('" & FileData  & "');"
%>
<object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"   codebase="http://webxpress/cargo/ptn_test2/print_utility/webx_dos_print.cab#version=1,0,0,0"></object>


<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<script language="Javascript">
alert("<%=FileData%>")
<%
		Response.write  FileData
%>
function print_click()
{	
	
	
	
	//window.close();
}

</script>
</HEAD>
<BODY>
<form name=frm onload="javascript:print_click()">
</form>
</BODY>
</HTML>
