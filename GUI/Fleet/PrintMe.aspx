<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintMe.aspx.cs" Inherits="GUI_Fleet_PrintMe" %>


<%--http://202.87.45.77/webx/dosprint//print_utility/ecfy_dos_print.cab#version=1,0,0,0--%>

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
   
<object id="objPrint" codeBase="http://202.87.45.77/webx/dosprint/print_utility/ecfy_dos_print.cab#version=1,0,0,0" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"    ></object>


<%--<object id="objPrint" codeBase="http://ashish/dosprint/print_utility/ecfy_dos_print.cab#version=1,0,0,0" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"    ></object>
--%>
    <title>Print Me</title>
    
    
		<script language="Javascript">
		<%
		string FileData = "";
        FileData = "objPrint.Print_Line('Hi Welcome to DOS PRINT');";
    
				Response.Write(FileData);
		%>
			//window.close();
		</script>
		
</head>
<body>

    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
