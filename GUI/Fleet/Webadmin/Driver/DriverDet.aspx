<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DriverDet.aspx.cs" Inherits="admin_DriverDet" %>

 
 <asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  
   <script language="javascript" type="text/javascript">
       
//       function getHost() {
//var url = window.location;
//var urlparts = url.split('/');
//var host = urlparts[0];
//alert(host);
//}

//        function checkEvent(tr_Submit)
//        {
//            tr_Submit.style["display"] = "none";  
//        }
      
      
        function nwOpen(mNo)
        {
            window.open("PopupVehicleNo.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        function popupMe(strFile)
        {
            //ctl00_MyCPH1_LblEBill
            var mstrFile =document.getElementById("ctl00_MyCPH1_" + strFile).innerText  
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://103.1.115.38/Ritco35/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }
        
    </script>

<script type="text/javascript">
function CHECKVALID() 
{
    var txtDriverName = document.getElementById("ctl00_MyCPH1_txtDriverName");
    var txtMDCode = document.getElementById("ctl00_MyCPH1_txtMDCode");
    var txtFather = document.getElementById("ctl00_MyCPH1_txtFather");
    var txtVehicleNo = document.getElementById("ctl00_MyCPH1_txtVehicleNo");
    var txtContact = document.getElementById("ctl00_MyCPH1_txtContact");
    var txtLicNo = document.getElementById("ctl00_MyCPH1_txtLicNo");
    var txtRTO = document.getElementById("ctl00_MyCPH1_txtRTO");
    var tb_Guarantor_Name = document.getElementById("ctl00_MyCPH1_tb_Guarantor_Name");
    var txtInitialDate = document.getElementById("ctl00_MyCPH1_txtInitialDate");
    var txtCurrentDate = document.getElementById("ctl00_MyCPH1_txtCurrentDate");
    var txtValDt = document.getElementById("ctl00_MyCPH1_txtValDt");
    var hfTodayDate =  document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDOB = document.getElementById("ctl00_MyCPH1_txtDOB");
    var txtLicVerifiedDate = document.getElementById("ctl00_MyCPH1_txtLicVerifiedDate");
    var chkLicVerified = document.getElementById("ctl00_MyCPH1_chkLicVerified");
    
	//Change by Jiten Ims isssue : VRL_003726 
    //if (!IsDateGreater(txtValDt.value, hfTodayDate.value)) 
    //{
    //    alert("License Validity Date Should be Future Date.");
    //    txtValDt.focus();
    //    return false;
    //}  
    
    if(txtDriverName.value== "")
    {
        alert("Enter Driver Name");
        txtDriverName.focus();
        return false;
    }
    if(txtMDCode.value== "")
    {
        alert("Enter Manual Driver Code");
        txtMDCode.focus();
        return false;
    }
    if(txtFather.value== "")
    {
        alert("Enter Driver's Father Name");
        txtFather.focus();
        return false;
    }
//    if(txtVehicleNo.value== "")
//    {
//        alert("Enter Vehicle Number");
//        txtVehicleNo.focus();
//        return false;
//    }
    if(txtContact.value== "")
    {
        alert("Enter Contact Number");
        txtContact.focus();
        return false;
    }
    if(txtLicNo.value== "")
    {
        alert("Enter License Number");
        txtLicNo.focus();
        return false;
    }
    if(txtValDt.value== "")
    {
        alert("Enter Validity Date");
        txtValDt.focus();
        return false;
    }
    if(txtRTO.value== "")
    {
        alert("Enter Issued By RTO");
        txtRTO.focus();
        return false;
    }
    if(tb_Guarantor_Name.value== "")
    {
        alert("Enter Guarantor Name");
        tb_Guarantor_Name.focus();
        return false;
    }
    if(txtDOB.value== "")
    {
        alert("Enter Date Of Birth.");
        txtDOB.focus();
        return false;
    }
    if (!IsDateGreater(hfTodayDate.value, txtDOB.value)) 
    {
        alert("Date Of Birth Date Should Not be Future Date.");
        txtDOB.focus();
        return false;
    }
    if(txtInitialDate.value== "")
    {
        alert("Enter License Initial Issue Date.");
        txtInitialDate.focus();
        return false;
    }
    if (!IsDateGreater(hfTodayDate.value, txtInitialDate.value)) 
    {
        alert("License Initial Issue Date Should Not be Future Date.");
        txtInitialDate.focus();
        return false;
    }  
    if(txtCurrentDate.value== "")
    {
        alert("Enter License Current Issue Date.");
        txtCurrentDate.focus();
        return false;
    }
    if (!IsDateGreater(hfTodayDate.value, txtCurrentDate.value)) 
    {
        alert("License Current Issue Date Should Not be Future Date.");
        txtCurrentDate.focus();
        return false;
    }  
    if(chkLicVerified.checked == true)
    {
        if(txtLicVerifiedDate.value== "")
        {
            alert("Enter License Verified Date.");
            txtLicVerifiedDate.focus();
            return false;
        }
    }
    if(txtLicVerifiedDate.value!= "")
    {
        if (!IsDateGreater(hfTodayDate.value, txtLicVerifiedDate.value)) 
        {
            alert("License Verified Date Should Not be Future Date.");
            txtLicVerifiedDate.focus();
            return false;
        } 
    }
    var ConFirmBox = confirm("Are you sure to submit data?");
    if (ConFirmBox == false) 
    {
        return false;
    }
    else 
    {
        document.getElementById('ctl00_MyCPH1_cmdSubmit').style.visibility = "hidden";
    }
    //return false;
    
}

function IsDateGreater(DateValue1, DateValue2) 
{
    var a = DateValue1.split("/");
    var b = DateValue2.split("/");
    DateValue1 = a[1] + "/" + a[0] + "/" + a[2];
    DateValue2 = b[1] + "/" + b[0] + "/" + b[2];
    if (Date.parse(DateValue1) == Date.parse(DateValue2))
        return true;
    else
        if (Date.parse(DateValue1) > Date.parse(DateValue2))
        return true;
    else
        return false;
}
</script>
    <!--End of Atlas Script Manager -->
    <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    
    <br />
    <p align="left">
        <table cellspacing="1" cellpadding="3" width="900px" class="boxbg"  >
              <tr style="background-color: white">
                  <td colspan="4" align="left">
                    <asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="true"></asp:Label> 
                    <asp:HiddenField ID="hfTodayDate" Value="" runat="server" /> 
                   </td> 
                </tr>
       
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Details"></asp:Label></td>
            </tr>
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="lblDriverCode" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Code:"></asp:Label>
                </td>
                <td align="left" colspan="3">
                    <asp:Label ID="lblDriverCodeVal" runat="server" CssClass="bluefnt" Text="Sys. Generated"></asp:Label>
                    <asp:HiddenField ID="hPrevDriverCode" runat="server" />
                </td>
                </tr>
                
                 <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Name:"></asp:Label>
                </td>
                <td align="left" >
                <asp:TextBox ID="txtDriverName" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
           <%-- </tr>
            
            
            
            <tr style="background-color: white">
               --%>
                <td align="left">
                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Manual Driver Code:"></asp:Label>
                </td>
                <td align="left">
                 <asp:UpdatePanel ID="UpdatePanel33" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                                <asp:TextBox ID="txtMDCode" runat="server" CssClass="input" AutoPostBack="true" OnTextChanged="txtMDCode_TextChanged" >
                    </asp:TextBox>
              <asp:Label ID="lblCheckCode" runat="server"  ForeColor="red" Visible="false"/>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtMDCode" EventName="TextChanged" />
                    </Triggers>
                        </asp:UpdatePanel>
                                         
                </td>
       </tr>
                                   
                                 
                       
                <tr style="background-color: white">
               
                <td align="left">
                    <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver's Father Name:"></asp:Label>
                </td>
                <td align="left" >
                <asp:TextBox ID="txtFather" runat="server" CssClass="input">
                    </asp:TextBox>
                
                    
                </td>
          <%--  </tr>--%>
            
           
           
           <%
               string Driver_WO_Vehicle = "N"; 
                   
               
               System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(Session["SqlProvider"].ToString().Trim());
               conn.Open();
               string sql = "Select * from WebX_Setup_Process";
        
               System.Data.SqlClient.SqlCommand sqlcmd1 = new System.Data.SqlClient.SqlCommand(sql, conn);
               System.Data.SqlClient.SqlDataReader r1 = sqlcmd1.ExecuteReader();
               if (r1.Read())
               {
                   if (r1["Driver_WO_Vehicle"] != null)
                   {
                       Driver_WO_Vehicle = r1["Driver_WO_Vehicle"].ToString().Trim();
                   }
               }
               r1.Close();
            %>
           
           <%-- <tr style="background-color: white">--%>
               
                <td align="left" >
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vehicle Number:"></asp:Label>
                   <%if (Driver_WO_Vehicle == "N")
                     { 
                         %>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVehicleNo"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                      <%}                       
                      %>  
                     
                     
                </td>
                <td align="left" >
                
               <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="input" AutoPostBack="true" OnTextChanged="txtVehicleNo_TextChanged">
                    </asp:TextBox>&nbsp;&nbsp;     <asp:Label ID="lblPopup"     runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(2)">...</a>'
                                Width="14px"></asp:Label>
                                <asp:Label ID="lblCheck" runat="server"  ForeColor="red" Visible="false"/>
             </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtVehicleNo" EventName="TextChanged" />
                    </Triggers>
                        </asp:UpdatePanel>
                    
                </td>
            </tr>
           
           
           
           
           
           
           
               <tr style="background-color: white">
               
                <td align="left">
                    <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Location:"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left">
                <asp:DropDownList ID="ddlLocation" runat="server" Width="127px"  >
                    </asp:DropDownList>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
            <%--</tr>


    <tr style="background-color: white">
               --%>
                <td align="left">
                    <asp:Label ID="lblContactNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Contact Number:"></asp:Label>
              
                </td>
                <td align="left" >
                <asp:TextBox ID="txtContact"  MaxLength="100" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
            </tr>



    <tr style="background-color: white">
               
                <td align="left">
                    <asp:Label ID="lblPAddress" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Permanent Address:"></asp:Label>
                 <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPAddress"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left">
                <asp:TextBox ID="txtPAddress" runat="server" CssClass="input" TextMode="MultiLine">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
          <%--  </tr>

             <tr style="background-color: white">--%>
               
                <td align="left">
                    <asp:Label ID="lblCity" runat="server" CssClass="blackfnt" Font-Bold="true" Text="City:"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCity"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left">
                <asp:TextBox ID="txtCity" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
            </tr>
            
            
          <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="lblPin" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Pin:"></asp:Label>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPin" SetFocusOnError="true"  
                        ErrorMessage="PIN Should be Numeric!" ValidationExpression="(^\d+$)"
                        Width="1px" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
                <td align="left">
                <asp:TextBox ID="txtPin" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
       <%--     </tr>
               <tr style="background-color: white">--%>
               
                <td align="left" >
                    <asp:Label ID="lblCAddress" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Current Address:"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCAddress"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left">
                <asp:TextBox ID="txtCAddress" runat="server" CssClass="input" TextMode="MultiLine">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
            </tr>
              
             <tr style="background-color: white">
               
                <td align="left">
                    <asp:Label ID="lblCity1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="City:"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtCity1"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" >
                <asp:TextBox ID="txtCity1" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
           <%-- </tr>

            <tr style="background-color: white">--%>
               
                <td align="left" >
                    <asp:Label ID="lblPin1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Pin:"></asp:Label>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtPin1" SetFocusOnError="true"  
                        ErrorMessage="PIN Should be Numeric!" ValidationExpression="(^\d+$)"
                        Width="1px" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
                <td align="left" >
                <asp:TextBox ID="txtPin1" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
            </tr>

          
          
          
             <tr style="background-color: white">
                <td align="left" >
                    <asp:Label ID="lblLicNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License No.:"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtLicNo" runat="server" CssClass="input" Width="250" >
                        </asp:TextBox>
                                  
    
                        
                </td>
            <%--</tr>
            <tr style="background-color: white">--%>
                <td align="left">
                    <asp:Label ID="lvlValDt" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Validity Date:"></asp:Label> 
                </td>
                <td align="left" >
                    <asp:TextBox ID="txtValDt" runat="server" CssClass="input" > 
                     </asp:TextBox>
                     <ajaxToolkit:CalendarExtender ID="CalendarExtender2" 
                                        Format="dd/MM/yyyy" 
                                        TargetControlID="txtValDt" runat="server" />
                        <asp:Label ID="lblddmmyy" runat="server" CssClass="blackfnt"  Text="(dd/mm/yyyy)"></asp:Label> 
                       <%--  <atlas:AutoCompleteExtender runat="server" ID="Extender2"    >
                        
             <atlas:AutoCompleteProperties Enabled="True" 
            TargetControlID="txtSuppName1" 
            ServiceMethod="GetBlogSupplierTitlesForAutoComplete"
            ServicePath="~/Service/AutoCompletePrism.asmx" MinimumPrefixLength="1"    />
            </atlas:AutoCompleteExtender>--%>
                    
                             </td>
                
            </tr>
                 
            <tr style="background-color: white">
                <td align="left"  >
                 <asp:Label ID="lblIssued" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Issued By RTO:"></asp:Label> 
             </td>
                <td align="left" >
                        <asp:TextBox ID="txtRTO" runat="server" CssClass="input" Width="250" TextMode="SingleLine"></asp:TextBox>
                 </td>
                <td align="left"  >
                    <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Guarantor Name:"></asp:Label> 
                </td>
                <td align="left" >
                    <asp:TextBox ID="tb_Guarantor_Name" runat="server" CssClass="input" Width="250" TextMode="SingleLine"></asp:TextBox>
                </td>
               
            </tr>
          
          
<tr style="background-color: white">

 <td align="left" >
    <asp:Label ID="lblFlag" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Status:"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cboStatus"
        ErrorMessage="*"></asp:RequiredFieldValidator>
</td>
<td align="left" >
    <asp:DropDownList ID="cboStatus" runat="server" >
     <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
    </asp:DropDownList>
   <%-- <asp:HiddenField ID="HiddenField1" runat="server" />--%>
    
</td>

 <td align="left" >
                    <asp:Label ID="lblCat" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Category Id :"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left">
                <asp:DropDownList ID="DdlCategory" runat="server" Width="127px"  >
                    </asp:DropDownList>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
               
</tr>
<tr style="background-color: white">

  <td align="left">
                    <asp:Label ID="lblDOB" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Date Of Birth:"></asp:Label> 
                </td>
                <td align="left" >
                    <asp:TextBox ID="txtDOB" runat="server" CssClass="input" > 
                     </asp:TextBox>   
                        <asp:Label ID="Label8" runat="server" CssClass="blackfnt"  Text="(dd/mm/yyyy)"></asp:Label> 

                     <ajaxToolkit:CalendarExtender ID="calExtenderDOB" 
                     Format="dd/MM/yyyy"  TargetControlID="txtDOB"   runat="server" />
                       <asp:Label ID="lblddmmyy1" runat="server" CssClass="blackfnt"  ></asp:Label> 
                       <%--  <atlas:AutoCompleteExtender runat="server" ID="Extender2"    >
                        
             <atlas:AutoCompleteProperties Enabled="True" 
            TargetControlID="txtSuppName1" 
            ServiceMethod="GetBlogSupplierTitlesForAutoComplete"
            ServicePath="~/Service/AutoCompletePrism.asmx" MinimumPrefixLength="1"    />
            </atlas:AutoCompleteExtender>--%>
                    
             </td>
    

                 <td align="left">
                    <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Ethnicity :"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left">
                <asp:DropDownList ID="DdlCity" runat="server" Width="127px"  >
                    </asp:DropDownList>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td> 
               
               
</tr>
<tr style="background-color: white">

  <td align="left">
                    <asp:Label ID="lblLicInitialDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Initial Issue Date:"></asp:Label> 
                    
                </td>
                <td align="left" >
                    <asp:TextBox ID="txtInitialDate" runat="server" CssClass="input"> 
                     </asp:TextBox>   
                     
                     <asp:Label ID="Label7" runat="server" CssClass="blackfnt"  Text="(dd/mm/yyyy)"></asp:Label> 
                      <ajaxToolkit:CalendarExtender ID="calExtenderInitialDate" 
                                        Format="dd/MM/yyyy" 
                                        TargetControlID="txtInitialDate"   runat="server" />
                       <asp:Label ID="lblddmmyy2" runat="server" CssClass="blackfnt"  ></asp:Label> 
                       <%--  <atlas:AutoCompleteExtender runat="server" ID="Extender2"    >
                        
             <atlas:AutoCompleteProperties Enabled="True" 
            TargetControlID="txtSuppName1" 
            ServiceMethod="GetBlogSupplierTitlesForAutoComplete"
            ServicePath="~/Service/AutoCompletePrism.asmx" MinimumPrefixLength="1"    />
            </atlas:AutoCompleteExtender>--%>
                             </td>
    

  <td align="left"  >
     <asp:Label ID="lblLiccurrentDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Current Issue Date:"></asp:Label> 
    
                </td>
  <td align="left" >
  <asp:TextBox ID="txtCurrentDate" runat="server" CssClass="input"  TextMode="SingleLine" ></asp:TextBox>
<ajaxToolkit:CalendarExtender ID="calExtendertxtCurrentDate"  Format="dd/MM/yyyy" 
  TargetControlID="txtCurrentDate"   runat="server" />
                       <asp:Label ID="lblddmmyy3" runat="server" CssClass="blackfnt"  Text="(dd/mm/yyyy)"></asp:Label> 
                       <%--  <atlas:AutoCompleteExtender runat="server" ID="Extender2"    >
                        
             <atlas:AutoCompleteProperties Enabled="True" 
            TargetControlID="txtSuppName1" 
            ServiceMethod="GetBlogSupplierTitlesForAutoComplete"
            ServicePath="~/Service/AutoCompletePrism.asmx" MinimumPrefixLength="1"    />
            </atlas:AutoCompleteExtender>--%>
</td>
</tr>

   <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Verified:"></asp:Label>
            </td>
            <td align="left" >
            <asp:CheckBox ID="chkLicVerified" runat="server" />
            </td>
            <td align="left" >
                <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address Verified:"></asp:Label>
            </td>
            <td align="left" >
                <asp:CheckBox ID="chkAddVerified" runat="server" />
            </td>
     </tr>
     
     <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Verified Date:"></asp:Label>
            </td>
            <td align="left" >
                <asp:TextBox ID="txtLicVerifiedDate" runat="server" CssClass="input"  TextMode="SingleLine" ></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1"  Format="dd/MM/yyyy" 
                        TargetControlID="txtLicVerifiedDate" runat="server" />
            </td>
             <td align="left" colspan="2">
               
            </td>
     </tr>

           <tr class="bgbluegrey">
                <td   align="center" colspan="4">
                    <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address Proof Document Type & No"></asp:Label>
                    </td>
             
            </tr>
           
             <tr style="background-color: white">
                 
                <td align="left" colspan="2" >
                  <asp:CheckBox ID="chkEBill"  runat="server"  Text="Electricity Bill"  cssclass="blackfnt"   ></asp:CheckBox> <asp:FileUpload ID="fileEBill"   runat="server" />
                  <a href="javascript:popupMe('LblEBill')"><asp:Label ID="LblEBill" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true" ></asp:Label></a>
                  
                    &nbsp; &nbsp; &nbsp;
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
                
                <td align="left" colspan="2">
                  <asp:CheckBox ID="chkTelBill"  runat="server"   Text="Telephone Bill"  cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileTelBill"  runat="server" />
                  <a href="javascript:popupMe('LblTelBill')"><asp:Label ID="LblTelBill" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                  
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
            
            </tr>
         
          <tr style="background-color: white">
                 
                <td align="left" colspan="2" >
                    <asp:CheckBox ID="chkBAStat"  runat="server"  Text="Bank Account Statement"   cssclass="blackfnt"  ></asp:CheckBox>
                    <asp:FileUpload ID="fileBAStat"   runat="server" />
                    <a href="javascript:popupMe('LblBAStat')">
                    <asp:Label ID="LblBAStat" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label>
                    </a>
                </td>
             
                <td align="left" colspan="2" >
                  <asp:CheckBox ID="chkPassport"  runat="server"   Text="Passport"  cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;<asp:FileUpload ID="filePassport"   runat="server" />
                   <a href="javascript:popupMe('LblPassport')"><asp:Label ID="LblPassport" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label>
                   </a>
                </td>
            </tr>
            
             <tr style="background-color: white">
                 
                <td align="left" colspan="2" >
                  <asp:CheckBox ID="chkRationCard"  runat="server"  Text="Ration Card"   cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileRationCard"   runat="server" />
                   <a href="javascript:popupMe('LblRationCard')"><asp:Label ID="LblRationCard" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </td>
                <td align="left" colspan="2" >
                    <asp:CheckBox ID="chkDriverRegistration"  runat="server"  Text="Driver�s Registration Form"   cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:FileUpload ID="fileDriverRegistration"   runat="server" />
                   <a href="javascript:popupMe('LblRegistrationForm')">
                   <asp:Label ID="LblRegistrationForm" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label>
                   </a>
                
            
                  </td>
            
            
            </tr>
      








                           <tr class="bgbluegrey" >
                <td   align="center" colspan="4">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="ID Proof Document Type & No"></asp:Label>
                    </td>
             
            </tr>
           
             <tr style="background-color: white">
                 
                <td align="left" colspan="2">
                  <asp:CheckBox ID="chkPass"  runat="server"  Text="Passport"  cssclass="blackfnt"   ></asp:CheckBox> <asp:FileUpload ID="filePass"   runat="server" />
                  <a href="javascript:popupMe('LblPass')"><asp:Label ID="LblPass" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                  
                  
                    &nbsp; &nbsp; &nbsp;
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
                
                <td align="left" colspan="2"  >
                  <asp:CheckBox ID="chkDLiscense"  runat="server"   Text="Driving Liscense"  cssclass="blackfnt"  ></asp:CheckBox><asp:FileUpload ID="fileDLiscense"  runat="server" />
                  <a href="javascript:popupMe('LblDLiscense')"><asp:Label ID="LblDLiscense" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
            
            </tr>
         
          <tr style="background-color: white">
                 
                <td align="left" colspan="2">
                  <asp:CheckBox ID="chkVotersID"  runat="server"  Text="Voter's ID"   cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileVotersID"   runat="server" />
                  <a href="javascript:popupMe('LblVotersID')"><asp:Label ID="LblVotersID" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left" colspan="2">
                  <asp:CheckBox ID="chkPCard"  runat="server"   Text="PAN CARD"  cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="filePCard"   runat="server" />
                   <a href="javascript:popupMe('LblPCard')"><asp:Label ID="LblPCard" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
            
            </tr>
                <tr style="background-color: white">
                 
                <td align="left" colspan="2">
               <asp:Label ID="lblPhoto"  runat="server"  Text="Photo:"   cssclass="blackfnt" Font-Underline="true"  ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <asp:FileUpload ID="filePhoto"   runat="server" />
                <a href="javascript:popupMe('LblDriverPhoto')"><asp:Label ID="LblDriverPhoto" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>


              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </td>
            
            <td align="left" colspan="2">
               <asp:Label ID="lblThumb_Impression"  runat="server"  Text="Thumb Impression :"   cssclass="blackfnt" Font-Underline="true"  ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:FileUpload ID="fileThumb"   runat="server" />
                <a href="javascript:popupMe('lblThumb')">
                <asp:Label ID="lblThumb" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label>
            </a>
            
            </td>
           
            </tr>






         
             
             
       
                      
            
            <tr style="background-color: white">
                <td colspan="4" align="right">
                    
                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="OnSubmit" OnClientClick="javascript:return CHECKVALID()" />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </p>
 </asp:Content>