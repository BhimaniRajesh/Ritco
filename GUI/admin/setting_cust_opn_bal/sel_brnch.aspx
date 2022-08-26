<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="sel_brnch.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_sel_brnch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

function nwOpen(mNo)
        {
           
            window.open("popupbranch.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }

function nwOpen1(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
 function nwOpen2(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
 function nwOpen3(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function Vendor_pop(mNo)
        {
           if(document.getElementById('ctl00_MyCPH1_txtBranchCode1').value=='')
             {
                          alert('PLz Select Vendor Branch')
                                                    //document.getElementById('ctl00_MyCPH1_txtBranchCode1').focus()
                          return false;
             }     
             if(document.getElementById('ctl00_MyCPH1_Dr_Vendortype').value == "")
			     {
			      alert("Please enter the 'Vendor Type'")
			        document.getElementById('ctl00_MyCPH1_Dr_Vendortype').focus();
			      return false;
			     }
			     str="branch=" + document.getElementById('ctl00_MyCPH1_txtBranchCode1').value + "&Vendortype=" + document.getElementById('ctl00_MyCPH1_Dr_Vendortype').value
            window.open("PopupVendor.aspx?"+str,null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no')

        }
        function Cust_pop(mNo)
        {
           if(document.getElementById('ctl00_MyCPH1_txtBranchCode').value=='')
             {
                          alert('PLz Select Customer Branch')
                                                    //document.getElementById('ctl00_MyCPH1_txtBranchCode1').focus()
                          return false;
             }     
            window.open("PopupCustomer.aspx?branch=" + document.getElementById('ctl00_MyCPH1_txtBranchCode').value,null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no')

        }
        
         function DRV_pop(mNo)
        {
           if(document.getElementById('ctl00_MyCPH1_txtBranchCode2').value=='')
             {
                          alert('PLz Select Driver Branch')
                                                    //document.getElementById('ctl00_MyCPH1_txtBranchCode1').focus()
                          return false;
             }     
            window.open("PopupDriver.aspx?branch=" + document.getElementById('ctl00_MyCPH1_txtBranchCode2').value,null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no')

        }
         function EMP_pop(mNo)
        {
           if(document.getElementById('ctl00_MyCPH1_txtBranchCode3').value=='')
             {
                          alert('PLz Select Employee Branch')
                                                    //document.getElementById('ctl00_MyCPH1_txtBranchCode1').focus()
                          return false;
             }     
            window.open("PopupEmp.aspx?branch=" + document.getElementById('ctl00_MyCPH1_txtBranchCode3').value,null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no')

        }
function fsubmit(txtCustCode,txtVendorCode,TXT_DRV_Code,Txt_Empcd,rd1,rd2,rd3,rd4)
		{
			//alert("hi..")
			if (rd1.checked == true)
			 {
			     if(document.getElementById('ctl00_MyCPH1_txtBranchCode').value == "")
			     {
			      alert("Please enter the 'Customer Branch Code'")
			     // document.getElementById('ctl00_MyCPH1_txtBranchCode').focus();
			      return false;
			     }
			 }
			 else if (rd2.checked == true)
			 {
			     if(document.getElementById('ctl00_MyCPH1_Dr_Vendortype').value == "")
			     {
			      alert("Please enter the 'Vendor Type'")
			     document.getElementById('ctl00_MyCPH1_Dr_Vendortype').focus();
			      return false;
			     }
			      if(document.getElementById('ctl00_MyCPH1_txtBranchCode1').value == "")
			     {
			      alert("Please enter the 'Vendor Branch Code'")
			      //document.getElementById('ctl00_MyCPH1_txtBranchCode1').focus();
			      return false;
			     }
			 }
			  else if (rd3.checked == true)
			 {
			      if(document.getElementById('ctl00_MyCPH1_txtBranchCode2').value == "")
			     {
			      alert("Please enter the 'Driver Branch Code'")
    		      return false;
			     }
			 }
			 else if (rd4.checked == true)
			 {
			      if(document.getElementById('ctl00_MyCPH1_txtBranchCode3').value == "")
			     {
			      alert("Please enter the 'Employee Branch Code'")
    		      return false;
			     }
			 }
			 if (rd1.checked == false && rd2.checked == false && rd3.checked == false && rd4.checked == false)
			 {
                alert("Please Select RadioButton")
                return false;
			 }
			 
			 //alert("Done")
			 txtCustCode.disabled=false
			 txtVendorCode.disabled=false
			 TXT_DRV_Code.disabled=false
			 Txt_Empcd.disabled=false
			 
			 document.getElementById('ctl00_MyCPH1_txtBranchCode').disabled=false
			 document.getElementById('ctl00_MyCPH1_txtBranchCode1').disabled=false
			 document.getElementById('ctl00_MyCPH1_txtBranchCode2').disabled=false
			  document.getElementById('ctl00_MyCPH1_txtBranchCode3').disabled=false
			 
		}	 
		
		
    </script>

    <br />
    <br />
    <br />
    <font class="blackfnt" color="red"><b>* <u>NOTE </u>:- Keep Blank Customer/Vendor/Driver
        code for All for Enterd Banch</b> </font>
    <br />
    <br />
    <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Type</font></td>
            <td>
                <font class="blackfnt">Effecive Account </font>
            </td>
            <td>
                <font class="blackfnt">Enter Customer </font>
            </td>
            <td>
                <font class="blackfnt">Enter Location </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <asp:RadioButton ID="rd1" runat="server" GroupName="abc" />
            </td>
            <td>
                <font class="blackfnt">
                    <asp:DropDownList runat="server" ID="Dracccode">
                    </asp:DropDownList></font>
            </td>
            <td>
                <asp:TextBox ID="txtCustCode" Enabled="false" runat="server" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="btnPopUp" type="button" value="..." name="custpup12" runat="server" />
                <%-- <asp:Label ID="lblCust" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(1)">...</a>'
                    Width="14px"></asp:Label>--%>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode" Enabled="false" runat="server" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="BTN_locpop" onclick="nwOpen(1);" type="button" value="..." name="Locpup12"
                    runat="server" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="6" align="center" class="blackfnt">
                OR
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Type</font></td>
            <td>
                <font class="blackfnt">Effecive Vendor Type </font>
            </td>
            <td>
                <font class="blackfnt">Enter Vendor </font>
            </td>
            <td>
                <font class="blackfnt">Enter Location </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <asp:RadioButton ID="rd2" runat="server" GroupName="abc" />
            </td>
            <td>
                <font class="blackfnt">
                    <asp:DropDownList runat="server" ID="Dr_Vendortype">
                    </asp:DropDownList></font>
            </td>
            <td>
                <asp:TextBox ID="txtVendorCode" runat="server" Enabled="false" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="btnPopUp1" type="button" value="..." name="custpup12" runat="server" />
                <%-- <asp:Label ID="lblVendor" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen1(1)">...</a>'
                    Width="14px"></asp:Label>--%>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode1" runat="server" Enabled="false" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="BTN_locpop1" onclick="nwOpen(2);" type="button" value="..." name="Locpup12"
                    runat="server" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="6" align="center" class="blackfnt">
                OR
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Type</font></td>
            <td>
                <font class="blackfnt">Effecive Account </font>
            </td>
            <td>
                <font class="blackfnt">Enter Driver </font>
            </td>
            <td>
                <font class="blackfnt">Enter Location </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <asp:RadioButton ID="rd3" runat="server" GroupName="abc" />
            </td>
            <td>
                <font class="blackfnt">
                    <asp:DropDownList runat="server" ID="DLL_DRV_COde">
                    </asp:DropDownList></font>
            </td>
            <td>
                <asp:TextBox ID="TXT_DRV_Code" runat="server" Enabled="false" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="Button1" type="button" value="..." name="custpup12" runat="server" />
                <%-- <asp:Label ID="lblVendor" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen1(1)">...</a>'
                    Width="14px"></asp:Label>--%>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode2" runat="server" Enabled="false" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="Button2" onclick="nwOpen(3);" type="button" value="..." name="Locpup12"
                    runat="server" />
            </td>
        </tr>
      
        <tr bgcolor="#FFFFFF">
            <td colspan="6" align="center" class="blackfnt">
                OR
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Type</font></td>
            <td>
                <font class="blackfnt">Effecive Account </font>
            </td>
            <td>
                <font class="blackfnt">Enter Employee </font>
            </td>
            <td>
                <font class="blackfnt">Enter Location </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <asp:RadioButton ID="rd4" runat="server" GroupName="abc" />
            </td>
            <td>
                <font class="blackfnt">
                    <asp:DropDownList runat="server" ID="DR_EMPLEdgerCOde">
                    </asp:DropDownList></font>
            </td>
            <td>
                <asp:TextBox ID="Txt_Empcd" runat="server" Enabled="false" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="btnPopUp2" type="button" value="..." name="custpup12" runat="server" />
                <%-- <asp:Label ID="lblVendor" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen1(1)">...</a>'
                    Width="14px"></asp:Label>--%>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode3" runat="server" Enabled="false" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <input id="BTN_locpop2" onclick="nwOpen(4);" type="button" value="..." name="Locpup12"
                    runat="server" />
            </td>
        </tr>
          <tr bgcolor="#FFFFFF">
            <td colspan="5" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
