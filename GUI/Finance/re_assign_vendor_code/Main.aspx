<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Main.aspx.cs" Inherits="GUI_Finance_re_assign_vendor_code_Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

   function nwOpen2(m1)
        {
            window.open("VendorCode.aspx?cd=" + m1,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
    function dktcheck(d)
    {
          var cbodoctype = document.getElementById("ctl00_MyCPH1_cboDocumentType").value
          if(cbodoctype!="")
            {
              var txtdno=d.id;
              var txtExVendor=d.id;
              txtExVendor=txtExVendor.replace( "txtDocumentNo", "txtExistingVendor");
              document.getElementById("ctl00_MyCPH1_hi").value=txtExVendor;
              var dno=d.value;
              var txExVehicle=txtdno.replace( "txtDocumentNo", "txtExistingVehNo");
              document.getElementById("ctl00_MyCPH1_h_Veh").value=txExVehicle;
                  
              var dno=d.value;
              
                    createXMLHTTPObject();
                    
                     if (doc)
				     { 
             	         arg=new Date()
					     doc.onreadystatechange = doWork; 
					     doc.open("GET", "./dochk.aspx?Search="+cbodoctype+"&dockno="+dno, false);
					     doc.send(null);
				      }
            }
          else
            {
                alert("Please Select Document Type !!!");
                return false;
            }
    }
    var doc = null; 
    var formobj;
    var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;
	
	function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) 
	    { 
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } 
	    else if (window.ActiveXObject) 
	    { 
	        try 
	        {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
	        catch (e) 
	        {
	            try 
	            {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } 
	            catch (e) 
	            {
	            
	            }
	        }
	    }
	}
	var p=true
	var res
	var txtVendor
	var txtVehicle
	function doWork() 
	{
	    if (doc.readyState == 4) 
	    {
	    
	           res=doc.responseText.split("|");
	           if (res[0]!="OKOK")
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
                <font class="blackfnt"><b>Re-Assign Vendor Code</b></font></td>
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
                        <font class="bluefnt">Document Type</font></td>
                    <td>
                    <asp:DropDownList ID="cboDocumentType" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="THC" Value="T"></asp:ListItem>
                    <asp:ListItem Text="PRS/DRS" Value="PD"></asp:ListItem>
                    </asp:DropDownList>
                     <asp:HiddenField ID="hi" runat="server" />
                     <asp:HiddenField ID="h_Veh" runat="server" />
                    </td>
                    <td align="left">
                        <font class="bluefnt">Enter Row No *</font></td>
                    <td>
                        <asp:TextBox ID="roww" runat="server" Width="30px"
                            BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25">
                        </asp:TextBox>
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
                                    <asp:TemplateField HeaderText="Existing Vendor" HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="80px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtExistingVendor" runat="server" Width="100" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Vendor">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="txtNewVendor" runat="server" Width="50" BorderStyle="Groove"></asp:TextBox>
                                        <asp:Button ID="btncodepopup" runat="server" />
                                            <%--<asp:DropDownList ID="cboNewVendor" runat="server" AutoPostBack="true"></asp:DropDownList>--%>
                                        </ItemTemplate>
                                        <ItemStyle BackColor="white" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing Vehicle No.">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle  BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtExistingVehNo" runat="server" Width="100" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Vehicle No." HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="100px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNewVehNo" runat="server" Width="100" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                               <%-- <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnSUbmit" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField> --%>
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
                    <br />
                    <asp:Label ID="lblError" runat="server" CssClass="redfnt" ></asp:Label>
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
