<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="sel_brnch.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_sel_brnch" %>
    
    <%@ Register Src="~/GUI/Common_UserControls/AutoComplete/CRM.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
    

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
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
			     if(document.getElementById('ctl00_MyCPH1_txtBranchCode').value == '')
			     {
			      alert("Please enter the 'Customer Branch Code'")
			      document.getElementById('ctl00_MyCPH1_txtBranchCode').focus();
			      return false;
			     }
			 }
			 else if (rd2.checked == true) {
//			 debugger;
//			     if (document.getElementById('ctl00_MyCPH1_Dr_Vendortype').value <= 0)
//			     {
//			          alert("Please enter the 'Vendor Type'")
//			          document.getElementById('ctl00_MyCPH1_Dr_Vendortype').focus();
//			          return false;
//			     }
			      if(document.getElementById('ctl00_MyCPH1_txtBranchCode1').value == '')
			     {
			      alert("Please enter the 'Vendor Branch Code'")
			      document.getElementById('ctl00_MyCPH1_txtBranchCode1').focus();
			      return false;
			     }
			 }
			  else if (rd3.checked == true)
			 {
			      if(document.getElementById('ctl00_MyCPH1_txtBranchCode2').value == '')
			     {
			      alert("Please enter the 'Driver Branch Code'")
				  document.getElementById('ctl00_MyCPH1_txtBranchCode2').focus();
    		      return false;
			     }
			 }
			 else if (rd4.checked == true)
			 {
			      if(document.getElementById('ctl00_MyCPH1_txtBranchCode3').value == '')
			     {
			      alert("Please enter the 'Employee Branch Code'")
                  document.getElementById('ctl00_MyCPH1_txtBranchCode3').focus();
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
    <font class="blackfnt" color="red"><b>* <u>NOTE </u>:- Keep Blank Customer/Vendor/Driver/Employee
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
                <font class="blackfnt">Enter Location </font>
            </td>
            <td>
                <font class="blackfnt">Enter Customer </font>
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
                <asp:TextBox ID="txtBranchCode" Enabled="true" runat="server" Width="100px" ></asp:TextBox>
                <asp:TextBox ID="txtBrachName" Enabled="false" runat="server" Width="150px" ></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxLocation" runat="server" WebxEntity="BranchCode"
                CodeTarget="txtBranchCode" NameTarget="txtBrachName" MinPrefixLength="3"  />
            </td>
            <td>
                <asp:TextBox ID="txtCustCode" Enabled="true" runat="server" Width="100px" 
                OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="txtCustName" Enabled="false" runat="server" Width="150px"></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxCustomer" runat="server" WebxEntity="Customer" 
                CodeTarget="txtCustCode" NameTarget="txtCustName" MinPrefixLength="3" FilterString=""  />
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
                <font class="blackfnt">Enter Location </font>
            </td>
            <td>
                <font class="blackfnt">Enter Vendor </font>
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
                <asp:TextBox ID="txtBranchCode1" runat="server" Enabled="true" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="txtBranchName1" runat="server" Enabled="false" Width="150px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxLocation1" runat="server" WebxEntity="BranchCode"
                CodeTarget="txtBranchCode1" NameTarget="txtBranchName1" MinPrefixLength="3"  />
                
            </td>
            <td>
                <asp:TextBox ID="txtVendorCode" runat="server" Enabled="true" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="txtVendorName" runat="server" Enabled="false" Width="150px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxVendor" runat="server" WebxEntity="Vendor" 
                CodeTarget="txtVendorCode" NameTarget="txtVendorName" MinPrefixLength="3" FilterString=""  />
                
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
                <font class="blackfnt">Enter Location </font>
            </td>
            <td>
                <font class="blackfnt">Enter Driver </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <asp:RadioButton ID="rd3" runat="server" GroupName="abc" Enabled="false" />
            </td>
            <td>
                <font class="blackfnt">
                    <asp:DropDownList runat="server" ID="DLL_DRV_COde">
                    </asp:DropDownList></font>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode2" runat="server" Enabled="true" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="txtBranchName2" runat="server" Enabled="false" Width="150px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxLocation12" runat="server" WebxEntity="BranchCode"
                CodeTarget="txtBranchCode2" NameTarget="txtBranchName2" MinPrefixLength="3"  />
                
            </td>
            <td>
                <asp:TextBox ID="TXT_DRV_Code" runat="server" Enabled="true" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="TXT_DRV_Name" runat="server" Enabled="false" Width="150px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxDRIVER" runat="server" WebxEntity="Driver" 
                CodeTarget="TXT_DRV_Code" NameTarget="TXT_DRV_Name" MinPrefixLength="3" FilterString=""  />
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
                <font class="blackfnt">Enter Location </font>
            </td>
            <td>
                <font class="blackfnt">Enter Employee </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <asp:RadioButton ID="rd4" runat="server" GroupName="abc"  Enabled="false" />
            </td>
            <td>
                <font class="blackfnt">
                    <asp:DropDownList runat="server" ID="DR_EMPLEdgerCOde">
                    </asp:DropDownList></font>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode3" runat="server" Enabled="true" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="txtBranchName3" runat="server" Enabled="false" Width="150px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>                
                <br />
                <xac:WebxComplete ID="WebxLocation3" runat="server" WebxEntity="BranchCode"
                CodeTarget="txtBranchCode3" NameTarget="txtBranchName3" MinPrefixLength="3"  />
            </td>
            <td>
                
                <asp:TextBox ID="Txt_Empcd" runat="server" Enabled="true" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:TextBox ID="Txt_EmpName" runat="server" Enabled="false" Width="150px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <br />
                <xac:WebxComplete ID="WebxEmployee" runat="server" WebxEntity="Employee" 
                CodeTarget="Txt_Empcd" NameTarget="Txt_EmpName" MinPrefixLength="3" FilterString=""  />
            </td>
            
        </tr>
          <tr bgcolor="#FFFFFF">
            <td colspan="5" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
