<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="TireMaster.aspx.cs" Inherits="admin_TireMaster" %>

  
   <%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
 
  
 
  <asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  
   
  <script language = "Javascript" >
function checkEvent ()
{
//alert("hi");

//alert(obj.value);
var tyreno = document.getElementById("ctl00$MyCPH1$txtTyreNo").value;
var tyretype= document.getElementById("ctl00$MyCPH1$ddlTyreType").value;
var mfg= document.getElementById("ctl00$MyCPH1$ddlManufacturer").value;

var size = document.getElementById("ctl00$MyCPH1$ddlSize").value; 
var PKms = document.getElementById("ctl00_MyCPH1_txtPKms").value;


var Cost = document.getElementById("ctl00$MyCPH1$txtCost").value;
var vehicleno = document.getElementById("ctl00_MyCPH1_ddlVehicleNo").value;
var location= document.getElementById("ctl00_MyCPH1_ddlLocation").value;



var WarrantyDt = document.getElementById("ctl00$MyCPH1$txtWarrantyDt").value;
var WExpKms= document.getElementById("ctl00$MyCPH1$txtWarrantyExpKms").value;
 
 
var TreadDepth = document.getElementById("ctl00$MyCPH1$txtTreadDepth").value;
var Pressure= document.getElementById("ctl00$MyCPH1$txtPressure").value;
 
 var axle = document.getElementById("ctl00$MyCPH1$txtAxle").value;
var wheel= document.getElementById("ctl00$MyCPH1$txtWheel").value;
 
 
var Pdate= document.getElementById("ctl00_MyCPH1_txtDate_useDateCal").value;
 
 



if(tyreno=="")
{
  alert("Please Enter Tyre No!")
    return false;
}


if(tyretype=="")
{
  alert("Please Enter Tyre Type!")
    return false;
}
if(mfg=="")
{
  alert("Please Enter  Manufacturer!")
    return false;
}
if(size=="")
{
  alert("Please Enter Size!")
    return false;
}


if(Pdate=="")
{
  alert("Please enter Purchase Date!")
    return false;
}







if(PKms=="")
{
  alert("Please Enter Purchase Kms!")
    return false;
}


  if(isNaN(PKms))
    {
    alert("Please Enter Purchase Kms in numeric .")
    return false;
    }
    
    
    
if(Cost=="")
{
  alert("Please Enter Cost!")
    return false;
}
if(isNaN(Cost))
    {
    alert("Please Enter Cost in numeric .")
    return false;
    }


if(vehicleno=="" && location=="")
 {

    
   
    alert("Either Vehicle No. OR Loacation  Should  be Entered!")
    return false;
    
    
 }
 
 
 if(vehicleno!="" && location!="")
 {

    
   
    alert("Either  one  from  Vehicle No. OR Loacation  Should  be Entered!")
    return false;
    
    
 }
 
 
 
 
 
 
 
 if(WarrantyDt=="" && WExpKms=="")
 {

 
    alert("Either Warranty Exp.Date  OR Warranty Exp.Kms Should  be Entered!")
    return false;
    
    
 }
 
  if(WarrantyDt!="" && WExpKms!="")
 {

 
    alert("Either one from  Warranty Exp.Date  OR Warranty Exp.Kms Should  be Entered!")
    return false;
    
    
 }
 
  if(isNaN(WExpKms))
    {
    alert("Please   Enter Expiry Kms in numeric .")
    return false;
    }
 
 
 
if(TreadDepth=="")
{
  alert("Please Enter Tread-Depth!")
    return false;
}
  if(isNaN(TreadDepth))
    {
    alert("Please   Enter TreadDepth in numeric .")
    return false;
    }
if(Pressure=="")
{
  alert("Please Enter Pressure!")
    return false;
}
  if(isNaN(Pressure))
    {
    alert("Please   Enter Pressure Kms in numeric .")
    return false;
    }

if(vehicleno!="" )
 {
 
 if(axle=="" && wheel=="")
 {
  alert("Both Axle & Wheel Configuration  Should  be Entered!!")
   return false;
  }
  }
    return true;
}

</script>



    <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" width="100%" >
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Master</asp:Label>
                <hr align="center"  color="#8ba0e5">
            </td>
        </tr>
    </table>
    
    <br /><br /><br />
    <p align="center">
        <table cellspacing="1" cellpadding="3" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tyre Details"></asp:Label></td>
            </tr>
            <tr style="background-color: white">
                <td align="left" colspan="1" >
                    <asp:Label ID="lblTireNo" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre No"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTyreNo"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
                <td align="left" colspan="1"  >
                    <asp:TextBox ID="txtTyreNo" runat="server" CssClass="input" Width="114px" ></asp:TextBox>
                  
                </td>
                 <td align="left"  colspan="1" >
                    <asp:Label ID="lblType" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tyre Type"></asp:Label>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlTyreType"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left"  colspan="1" >
                    <asp:DropDownList ID="ddlTyreType" runat="server" CssClass="input" Width="121px" ></asp:DropDownList>
                   
                </td>
                
                
                
                </tr>
                
                 <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 26px">
                    <asp:Label ID="lblManufactur" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Manufacturer"></asp:Label>
                    <asp:RequiredFieldValidator ID="RFVProductType" runat="server" ControlToValidate="ddlManufacturer"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1" style="height: 26px" >
                <asp:DropDownList ID="ddlManufacturer" runat="server" CssClass="input" Width="121px">
                    </asp:DropDownList>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                <td align="left" colspan="1" style="height: 26px">
                    <asp:Label ID="lblSize" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Size"></asp:Label>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidat1" runat="server" ControlToValidate="ddlSize"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                </td>
                <td align="left" colspan="1" style="height: 26px">
                <asp:DropDownList ID="ddlSize" runat="server" CssClass="input" Width="121px"></asp:DropDownList>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                
                
            </tr>
           
           
               <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblPDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Purchase Date"></asp:Label>    <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="(dd/mm/yyyy)"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                        ErrorMessage="*"></asp:RequiredFieldValidator>  --%> 
                </td>
                <td align="left" colspan="1" >
              <DateCalendar:Header ID="txtDate" runat="server"></DateCalendar:Header>  
      <%--   <asp:TextBox ID="txtPDate" runat="server"  CssClass="input" Width="121px"  ></asp:TextBox>--%>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                 <td align="left" colspan="1">
                    <asp:Label ID="lblPKms" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Purchase Kms"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1">
                <asp:TextBox ID="txtPKms" runat="server"  CssClass="input" Width="121px"></asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                     
                
                
            </tr>


    <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 96px">
                    <asp:Label ID="lblOE" runat="server" CssClass="blackfnt" Font-Bold="true" Text="OE(Original Equipment)"></asp:Label>
                 <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtContact"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left"  colspan="1" style="height: 96px" >
                   
                <asp:DropDownList ID="ddlOE" runat="server" AutoPostBack="true" CssClass="input" Width="57px" OnSelectedIndexChanged="ddlOE_SelectedIndexChanged">
                    <asp:ListItem>YES</asp:ListItem>
                    <asp:ListItem>NO</asp:ListItem>
                    </asp:DropDownList>
                   
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                  <td align="left" colspan="1" style="height: 96px">
                    <asp:Label ID="lblCost" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Cost"></asp:Label>
                 <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtContact"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1" style="height: 96px">
                      <asp:UpdatePanel ID="UPShow" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                <asp:TextBox ID="txtCost" runat="server" CssClass="input" Width="121px"></asp:TextBox>
                   
                      </ContentTemplate>
                      <Triggers>
                      <asp:AsyncPostBackTrigger ControlID="ddlOE" EventName="SelectedIndexChanged" />
                        </Triggers>
                            </asp:UpdatePanel>
                    
                </td>
            </tr>



<%--    <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblPAddress" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Permanent Address:"></asp:Label>
                 <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPAddress"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                </td>
                <td align="left" colspan="1">
                <asp:TextBox ID="txtPAddress" runat="server" CssClass="input" TextMode="MultiLine">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>
                     
                    
                </td>
                  <td align="left" colspan="2">
                  </td>
            </tr>--%>

             <tr style="background-color: white">
               
                <td align="left" colspan="1" >
                    <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vehicle No"></asp:Label>
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCity"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1">

                <asp:DropDownList ID="ddlVehicleNo" runat="server" CssClass="input" Width="121px" ></asp:DropDownList> <%--<asp:Button ID="btnVehicleNo" runat="server" Text=".." Width="24px" />--%>
                  </td>
                 <td align="left" colspan="1">
                     <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="true" Text="OR"></asp:Label>
                      <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Location"></asp:Label>
                     </td>
                        <td align="left" colspan="1">
                         <asp:DropDownList ID="ddlLocation" runat="server" CssClass="input" Width="90px"  ></asp:DropDownList>                    <%--<asp:Button ID="btnLocation" runat="server" Text=".." Width="24px" />&nbsp;--%>
                     </td>
            </tr>
            
            
          <tr style="background-color: white">
               
                <td align="left" colspan="1" >
                    <asp:Label ID="lblWarantty" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Warranty Expires"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtPin"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1" >
                               <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="On"></asp:Label>
             <%--  <DateCalendar:Header ID="txtDate1" runat="server"></DateCalendar:Header>   --%>        
               <asp:TextBox ID="txtWarrantyDt" runat="server" CssClass="input" Width="100px"></asp:TextBox> 
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                <td align="left" colspan="1" >
                    <asp:Label ID="lblAt" runat="server" CssClass="blackfnt" Font-Bold="true" Text="OR"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtPin"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left"  colspan="1" >
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="At"></asp:Label>
                <asp:TextBox ID="txtWarrantyExpKms" runat="server" CssClass="input" Width="80px"></asp:TextBox>
                  <asp:Label ID="Label3" runat="server" CssClass="blackfnt"   Text="Kms"></asp:Label>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                
            </tr>

              
               <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 25px">
                    <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"  Font-Bold="true" Text="Vendor"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCAddress"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1" style="height: 25px"  >
                <asp:DropDownList ID="ddlVendor" runat="server" CssClass="blackfnt" width="128px"  >
                    </asp:DropDownList>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                  <td align="left" colspan="2" style="height: 25px" >
                  </td>
            </tr>
              
             <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblTreadDepth" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tread Depth"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtCity1"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1" >
                <asp:TextBox ID="txtTreadDepth" runat="server" CssClass="input" Width="121px"></asp:TextBox>&nbsp;
                      <asp:Label ID="Label5" runat="server" CssClass="blackfnt"   Text="32nds"></asp:Label>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                <td align="left" colspan="1">
                    <asp:Label ID="lblPressure" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Pressure"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtCity1"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
               
               <td align="left" colspan="1">
                    <asp:TextBox ID="txtPressure" runat="server" CssClass="input"    Width="96px"></asp:TextBox>
                     <asp:Label ID="Label4" runat="server" CssClass="blackfnt"  Text="psi"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtCity1"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
               
                
            </tr>
            
            <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblAxle1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Axle Wheel Configuration"></asp:Label>
                 <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtPin1"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1" >
                <asp:TextBox ID="txtAxle" runat="server" CssClass="input" Width="121px"></asp:TextBox><asp:Label ID="Label6" runat="server" CssClass="blackfnt"  Text="Axle"></asp:Label>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                 <td align="left" colspan="2">
                <asp:TextBox ID="txtWheel" runat="server" CssClass="input" Width="56px"></asp:TextBox><asp:Label ID="Label7" runat="server" CssClass="blackfnt"  Text="Wheel"></asp:Label>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                <%--  <td align="left" colspan="1">
               <asp:TextBox ID="TextBox1" runat="server" CssClass="input">
                    </asp:TextBox>--%>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>
                     
                    
                </td>--%>
            </tr>
                      <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Category"></asp:Label></td>
                <td align="left" colspan="1" ><asp:DropDownList ID="ddlTyreCategory" runat="server" CssClass="blackfnt" width="198px"  >
                </asp:DropDownList></td>
                
                <td align="left" colspan="1">
                    <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Tread Pattern"></asp:Label></td>
               
               <td align="left" colspan="1"><asp:DropDownList ID="ddlTreadPattern" runat="server" CssClass="blackfnt" width="128px"  >
               </asp:DropDownList></td>
               
                
            </tr>
 
              <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 28px" >
                    <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Active Flag"></asp:Label>&nbsp;
                </td>
                <td align="left" colspan="1">
                    <asp:DropDownList ID="cboActive" runat="server"  Width="65px">
                     <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
                    </asp:DropDownList>
                  <%--  <asp:HiddenField ID="HiddenField1" runat="server" />--%>
                    
                </td>
                <td colspan="2">
                </td>
                
                
                
            </tr>
            <tr style="background-color: white">
                <td colspan="4" align="right">
                    <asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="false"></asp:Label>  
                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click"  />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </p>
 </asp:Content>