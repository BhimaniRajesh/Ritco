<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EmployeeEdSelect.aspx.cs" Inherits="GUI_admin_Employee_EmployeeEdSelect"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
       
        function nwOpen()
        {
            window.open("popupEmp.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        function nwOpen2()
        {
            window.open("popupusrid.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        function IsText(sText)
        {
           var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
           var IsText=true;
           var Char;

           for (i = 0; i < sText.length && IsText == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsText = false;
              }
           }
           
           return IsText;
        }
        
        function ValidateData()
            {
             
              if(document.getElementById("ctl00_MyCPH1_ddHir").value == "--Select--" && document.getElementById("ctl00_MyCPH1_txtmgrid").value == "" && document.getElementById("ctl00_MyCPH1_txtuid").value == "")
               {
                   if(document.getElementById("ctl00_MyCPH1_ddHir").value == "--Select--" && document.getElementById("ctl00_MyCPH1_ddLoc").value == "--Select--")
                        {
                            alert("Select Hirarchy ");
                            document.getElementById("ctl00_MyCPH1_ddHir").focus();
                            return false;
                        }
                   else if(document.getElementById("ctl00_MyCPH1_ddLoc").value == "--Select--" && document.getElementById("ctl00_MyCPH1_ddEmployee").value == "")
                        {
                            alert("Select Location ");
                            document.getElementById("ctl00_MyCPH1_ddLoc").focus();
                            return false;
                        }
                   else (document.getElementById("ctl00_MyCPH1_ddEmployee").value == "")
                        {
                            alert("Select Employee ");
                            document.getElementById("ctl00_MyCPH1_ddEmployee").focus();
                            return false;
                        }
                }
               else if(document.getElementById("ctl00_MyCPH1_ddEmployee").value == "" && document.getElementById("ctl00_MyCPH1_txtmgrid").value == "" && document.getElementById("ctl00_MyCPH1_txtuid").value == "")
                {
                    alert("Select User Id OR Employee Code ");
                    document.getElementById("ctl00_MyCPH1_ddEmployee").focus();
                    return false;
                }
                               
                return true;
            }     
            
             function checklocation(obj)
        {
        
        var a;
        a=1;
     obj.value = obj.value.toUpperCase()
        //str=str.toUpperCase()
        
        if(obj.value != "")
        {
       for(i=0;i<str.length;i++)
       {
       
       str[i]=str[i].toUpperCase()

            if(obj.value==str[i])
            {
                 a=2
                  break;
               
                
            }
            else
            { 
               
                continue
            }
       }
      
       if(a!=2)
       {
             alert("Employee ID Does Not Exist....")
           obj.focus();
       }
       }
 

}   


function checklocation2(obj)
        {
        
        
        var a;
        a=1;
       obj.value = obj.value.toUpperCase()
       //  str2=str2.toUpperCase()
        if(obj.value != "")
        {
       for(i=0;i<str2.length;i++)
       {
       str2[i]=str2[i].toUpperCase()

            if(obj.value==str2[i])
            {
            
                 a=2
                  break;
               
                
            }
            else
            { 
               
                continue
            }
       }
      
       if(a!=2)
       {
             alert("User ID Does Not Exist....")
           obj.focus();
       }
       }
 

}          
                    
    </script>

    <div style="width: 10in">
        <br />
        <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td>
                    <a href=""><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a href=""><font
                        class="blklnkund"><b>Administrator</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                            <b>Company Structure</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Employee Master</b></font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <table border="0" cellpadding="3" width="66%" bgcolor="#808080" cellspacing="1" align="center"
            class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <p align="center">
                        <font class="blackfnt"><b>Select Employee for Edit/Inactivation</b></font></p>
                </td>
            </tr>
            <tr align="left" bgcolor="#FFFFFF">
                <td valign="top" width="40%">
                    <div align="left">
                        <font class="blackfnt">Select Hierarchy</font> :
                    </div>
                </td>
                <td bgcolor="#FFFFFF">
                    <asp:UpdatePanel ID="upHir" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddHir" runat="server" OnSelectedIndexChanged="ddHir_SelectedIndexChanged"
                                Width="100px" AutoPostBack="True">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF" align="left">
                <td valign="top">
                    <font class="blackfnt">Select Location</font> :
                </td>
                <td bgcolor="#FFFFFF">
                    <div id="ReportingLocationCombo">
                        <asp:UpdatePanel ID="upLoc" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddLoc" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddLoc_SelectedIndexChanged">
                                </asp:DropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddHir" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF" align="left">
                <td valign="top">
                    <div>
                        <font class="blackfnt">Select Employee</font> :
                    </div>
                </td>
                <td bgcolor="#FFFFFF" align="left">
                    <div id="EmployeeCombo">
                        <asp:UpdatePanel ID="upEmpl" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddEmployee" runat="server">
                                </asp:DropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddLoc" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td colspan="2" align="center">
                    <font class="blackfnt"><b>OR</b></font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF" align="left">
                <td>
                    <font class="blackfnt">Enter Employee Code:</font>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtmgrid" runat="server" onblur="return checklocation(this)" Width="75px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen()">...</a>'
                        Width="14px"></asp:Label></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td colspan="2" align="center">
                    <font class="blackfnt"><b>OR</b></font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF" align="left">
                <td>
                    <font class="blackfnt">Enter User Id:</font>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtuid" runat="server" onblur="return checklocation2(this)" Width="75px"></asp:TextBox>
                    <asp:Label ID="Label2" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen2()">...</a>'
                        Width="14px"></asp:Label></td>
            </tr>
            <tr bgcolor="#FFFFFF" align="left">
                <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                    <table style="width: 292px">
                        <tr>
                            <td>
                                <%--<asp:UpdatePanel ID="upBtns1" runat="server">
   	                                <ContentTemplate>--%>
                                <asp:Button ID="btnAdd" runat="server" Width="80" Text="Add" OnClick="btnAdd_Click" />
                                <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />    
	                                </Triggers> 
                                </asp:UpdatePanel> --%>
                            </td>
                            <td>
                                <%--<asp:UpdatePanel ID="upBtns2" runat="server">
   	                                <ContentTemplate> --%>
                                <asp:Button ID="btnEdit" runat="server" Width="80"  Text="Edit" OnClientClick="return ValidateData()"
                                    OnClick="btnEdit_Click" />
                                <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />    
	                                </Triggers>
                                </asp:UpdatePanel> --%>
                            </td>
                            <td>
                                <%--<asp:UpdatePanel ID="upBtns3" runat="server">
   	                                <ContentTemplate> --%>
                                   <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnInactivate" EventName="Click" />    
	                                </Triggers>
                                </asp:UpdatePanel>--%>
                            </td>
                            <td>
                                <%--<asp:UpdatePanel ID="upBtns4" runat="server">
   	                                <ContentTemplate>  --%>
                                <asp:Button ID="btnListing" runat="server" Width="80"  Text="Listing" OnClick="btnListing_Click" />
                                <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnListing" EventName="Click" />    
	                                </Triggers>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
