<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="Prepareclaims.aspx.cs" Inherits="_Default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  
  <script language="Javascript"  >
function checkEvent ()
{
 
 var Docket = document.getElementById("ctl00$MyCPH1$txtDocketNo").value;
 
 var NonDel = document.getElementById("ctl00_MyCPH1_chkNonDelivery").checked;

var Short= document.getElementById("ctl00_MyCPH1_chkShortage").checked;
var Dam= document.getElementById("ctl00_MyCPH1_chkDamage").checked;
 
var Leakage = document.getElementById("ctl00_MyCPH1_chkLeakage").checked;
var Pilferage= document.getElementById("ctl00_MyCPH1_chkPilferage").checked;
var other= document.getElementById("ctl00_MyCPH1_chkOther").checked;


var bill = document.getElementById("ctl00_MyCPH1_rdBill").checked;
var cash= document.getElementById("ctl00_MyCPH1_rdCash").checked;
var cof= document.getElementById("ctl00_MyCPH1_rdCOF").checked;


var consingor = document.getElementById("ctl00_MyCPH1_rdConsignor").checked;
var consignee= document.getElementById("ctl00_MyCPH1_rdConsignee").checked;
var other1= document.getElementById("ctl00_MyCPH1_rdOther").checked;



  if(Docket=="")

  {

   alert("Docket No cannot  be blank!!")
   
    return false;

   }

//if((NonDel==false && Short==false && Dam==false && Leakage==false && Pilferage==false && other==false) || ( bill==false && cash==false && cof==false ) || (consingor==false  && consignee==false && other1==false))
//{


    if(NonDel==false && Short==false && Dam==false && Leakage==false && Pilferage==false && other==false)
   {

      
    alert("Please Select  Claim Basis")
   
    return false;
  }
 
    
    
    if(bill==false && cash==false && cof==false)
 {

  
    alert("Please Select  Claim Settlement Basis")
   
    return false;
}
 
  if(consingor==false  && consignee==false && other1==false)
 {
     alert("Please Select  Claim Party")
   
    return false;
} 

}
//}
    
</script>
    

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">CIR >CIR Entry</asp:Label>
            </td>
           <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
          </td>    
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br/>
    <br/>
       <br/>
    <br/>
      <table cellspacing="1" cellpadding="3"    width="90%" >
         <tr style="background-color: white" >
                <td   align="center">
                
                  <asp:Label ID="Label1" CssClass="bluefnt" Font-Bold="True"  Font-Size="12"  runat="server">Prepare New Claims Investigation Report</asp:Label> 
     </td>
     </tr>
          </table>
          <br/>
            <br/>
   <p align="center"> 
    <table cellpadding="3"  cellspacing="1"  class="boxbg" border="0">
    <tr style="background-color:White" align="center">
    <td align="center">
    <br/>
     <asp:UpdatePanel ID="UpdatePanel7" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
        <table cellspacing="1" cellpadding="3"    width="800px" class="boxbg" border="0" >
            
     <tr style="background-color: white" >
                <td colspan="6" align="center">
                    <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    </td>
                           
                    
            </tr>
         
           
             <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Enter Docket No.</font>
                </td>
                <td align="left" colspan="2">
                  <asp:TextBox ID="txtDocketNo" CssClass="input" runat="server"   MaxLength="9"   ></asp:TextBox>
                   <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1" style="width: 120px">
                <font class="bluefnt">Suffix(if any)</font>
                </td>
                <td align="left" colspan="2">
                <asp:TextBox ID="txtSiffix" CssClass="input" runat="server"  MaxLength="1"     ></asp:TextBox>
                </td>
            </tr>
            
           
            
             <tr class="bgbluegrey"> 
              <%--<tr style="background-color:White">--%>
                <td colspan="6" align="center">
                    <asp:Label ID="lblHeading2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Claims Basis"></asp:Label></td>
                           
                    
            </tr>
           
            
            
            
             <tr style="background-color: white">
                <td align="center"  >
                  <asp:CheckBox ID="chkNonDelivery" runat="server" CssClass="bluefnt"  Text="Non-Delivery" Width="117px" />
                </td>
                <td align="center" style="width: 96px"  >
               <asp:CheckBox ID="chkShortage" runat="server" CssClass="bluefnt"  Text="Shortage"/>
                </td>
                
                 <td align="center" style="width: 107px"  >
                  <asp:CheckBox ID="chkDamage" runat="server"  CssClass="bluefnt" Text="Damage"/>
               
                </td>
                 <td align="center" style="width: 120px"  >
                 <asp:CheckBox ID="chkLeakage" runat="server" CssClass="bluefnt" Text="Leakage"/>
              
                </td>
                
                 <td align="center" style="width: 100px"  >
                  <asp:CheckBox ID="chkPilferage" runat="server" CssClass="bluefnt" Text="Pilferage"/>
              
                </td>
                 <td align="center" style="width: 95px"  >
                 <asp:CheckBox ID="chkOther" runat="server"  CssClass="bluefnt" Text="Other" Width="81px" />
                      </td>
            </tr>
            
            
         
            
             <tr class="bgbluegrey">
                <td colspan="6" align="center">
                    <asp:Label ID="lblHeading3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Claims Settelement Basis"></asp:Label></td>
                           
                    
            </tr>
           
            
              <tr style="background-color: white">
                <td align="center"   colspan="2">
                  <asp:RadioButton ID="rdBill" runat="server" Text="Bill"  CssClass="bluefnt" GroupName="ClaimBasis" Width="117px" />
                </td>
                <td align="center"  colspan="2">
               <asp:RadioButton ID="rdCash" runat="server"  CssClass="bluefnt" GroupName="ClaimBasis"  Text="Cash"/>
                </td>
                
                 <td align="center"  colspan="2">
                  <asp:RadioButton ID="rdCOF" runat="server"  CssClass="bluefnt" GroupName="ClaimBasis"  Text="COF"/>
               
                </td>
               
            </tr>
            
            
            
            
          
             
            
            
             <tr class="bgbluegrey">
                <td colspan="6" align="center">
                    <asp:Label ID="lblHeading4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Claims Party"></asp:Label></td>
                           
                    
            </tr>
           
            
              <tr style="background-color: white">
                <td align="center"  colspan="2">
                  <asp:RadioButton ID="rdConsignor"  CssClass="bluefnt" GroupName="PartyBasis" runat="server" Text="Consignor" Width="117px" />
                </td>
                <td align="center" colspan="2" >
               <asp:RadioButton ID="rdConsignee"  CssClass="bluefnt"  GroupName="PartyBasis" runat="server"  Text="Consignee"/>
                </td>
                
                 <td align="center"  colspan="2">
                  <asp:RadioButton ID="rdOther"  CssClass="bluefnt"  GroupName="PartyBasis"  runat="server"  Text="Other"/>
               
                </td>
               
            </tr>
            </table>
            <br/>
            <br/>
              <p align="center">
         <table cellspacing="1" cellpadding="3"    width="80%" >
            <tr style="background-color:White">
            <td align="reght">
               <asp:Label ID="lblError1" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
               <asp:Label ID="lblError2" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
            </td>
            </tr>
            
             <tr align="center" >
             <td align="center" colspan="6">
         <asp:Button ID="cmdGo" runat="server" Text="Go" OnClick="cmdGo_Click"  />
            </td>
            </tr>
            </table>
           
    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cmdGo" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                </td>
                                </tr>
                                </table>
     </p> 
</asp:Content>            

