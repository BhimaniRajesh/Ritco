<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="GUI_Operations_THC_Reassign_Location_Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
//function validInt(event)
//    {
//        if(event.keyCode==13)
//        {
//        return true;
//        }
//        if(event.keyCode<48 || event.keyCode>57)
//        {
//        event.keyCode=0;return false;
//        }
//    }
   function nwOpen2(m1)
        {
            window.open("LocationCode.aspx?cd=" + m1,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
    function dktcheck(d)
    {
              var txtdno=d.id;
              var txtExLocation=d.id;
              txtExLocation=txtExLocation.replace( "txtDocumentNo", "txtExistingLocation");
              document.getElementById("ctl00_MyCPH1_hi").value=txtExLocation;
              var dno=d.value;
              
                    var doc=GetXMLHttpObject();
                    
                     if (doc)
				     { 
             	         arg=new Date();
					     doc.onreadystatechange = doWork; 
					     doc.open("GET", "./dochk.aspx?dockno="+dno, false);
					     doc.send(null);
				      }
           
    }
    
  
    
    var MyDiv = document.getElementById("ReportingToCombo");
	
	var p=true
	var res
	var txtVendor
	var txtVehicle
	function doWork() 
	{
	    if (doc.readyState == 4) 
	    {debugger
	           res=doc.responseText.split("|");
	           if (res[0]!="OK")
	            {
	                alert(res[0])
	                p=false
	                rt=""
	                return false
	            }
	            else
	            {
                     
                      var s= document.getElementById("ctl00_MyCPH1_hi").value;
	                  document.getElementById(s).value = res[2];
	                  
	                  var hamt= document.getElementById("ctl00_MyCPH1_h_Veh").value;
	                  document.getElementById(hamt).value = res[3];
	            }
	    }
	}
     
     
    </script>

    <br />
    <table border="0" align="left" cellspacing="1" cellpadding="2" style="width:9.5in" class="boxbg">
        <tr bgcolor="#ffffff">
            <td height="26" bgcolor="#FFFFFF" align="center">
                <font class="blackfnt"><b>Re-Assign THC Location</b></font></td>
        </tr>
    </table>
     <br />
     <br />
     <br />
     <br />
    <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>
            <table border="0" align="left" cellspacing="1" cellpadding="2" style="width:9.5in" class="boxbg">
                <tr bgcolor="#ffffff">
               
                    <td align="left">
                        <font class="bluefnt">Enter Row No *</font></td>
                    <td>
                        <asp:TextBox ID="roww" runat="server" Width="30px"
                            BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25">
                        </asp:TextBox>
                        <asp:HiddenField ID="hi" runat="server" />
                     <asp:HiddenField ID="h_Veh" runat="server" />
                   
                    </td>
                </tr>
            </table>
             <br />
             <br />
             <br />
             <br />
                        <div align="left">
                            <asp:GridView ID="GridVendor" runat="server" align="left" HeaderStyle-CssClass="bgbluegrey"
                                CellPadding="3" CellSpacing="1" BorderWidth="0" PagerStyle-HorizontalAlign="left"
                                CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="GridVendor_OnRowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document No" HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="80px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDocumentNo" runat="server" Width="100" onblur="return dktcheck(this)" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing Location" HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="80px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtExistingLocation" runat="server" Width="100" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Location">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="txtNewLocation" runat="server" Width="50" BorderStyle="Groove"></asp:TextBox>
                                        <asp:Button ID="btncodepopup" runat="server" />
                                            <%--<asp:DropDownList ID="cboNewVendor" runat="server" AutoPostBack="true"></asp:DropDownList>--%>
                                        </ItemTemplate>
                                        <ItemStyle BackColor="white" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    
                                </Columns>
                                
                                <FooterStyle CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgbluegrey" />
                            </asp:GridView>
                            <br />
                 <br />
                 <br />
                 <br />
                 <br />
                 <br />
                 <br />
                <div align="left" style="width: 10in">
                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" TabIndex="9" Visible="false"/>
                        </div>
                 
        </ContentTemplate>
    </asp:UpdatePanel>
   <%-- <br />
                 <br />
                 <br />
                 <br />
                 <br />
                <div align="left" style="width: 10in">
                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" TabIndex="9" Visible="false"/>
                </div>--%>
</asp:Content>
