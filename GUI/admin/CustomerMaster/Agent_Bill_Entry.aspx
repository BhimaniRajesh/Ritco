<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Agent_Bill_Entry.aspx.cs" Inherits="octroi_OctCustBillStep2"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

function check(octamt,txtagnttax,txtothrchg,txtfrmcharg,txtclearchrg,txttotdue,txtserchgper,txtservicetxtchrg,txtsundry,h1)
{
var varoctamt = octamt.value
var varagnttax = txtagnttax.value
var vartotdue = txttotdue.value 
var varothrchg = txtothrchg.value 
var varfrmcharg = txtfrmcharg.value 
var varclearchrg = txtclearchrg.value 
//vartotdue  = txttotdue.value 
var varserchgper = txtserchgper.value 
var varservicetxtchrg = txtservicetxtchrg.value 
var varsundry = txtsundry.value
//alert("Sandy")
//debugger
if(isNaN(txtagnttax.value))
{
    alert("Please Enter Only Numeric Value")
    txtagnttax.focus();
    return false
}
if((txtagnttax.value)<0)
{
    alert("Please Enter Positive Value")
    txtagnttax.focus();
    return false
}

var totalrow=document.getElementById("ctl00$MyCPH1$roww").value
//alert(totalrow)
    var Formnae="ctl00$MyCPH1$GV_D$ctl"//02$txtoctamt"
    var total_octamt=0
    var octamount=0
    for (i=0;i<totalrow;i++ )
    {
//alert(i)
        j=i+2
        
        if(i<10)
        {
            GV_frmname=Formnae+"0"+j+"$"
            //GV_frmname1=Formnae+"0"+k+"$"
        }
        else
        {
        GV_frmname=Formnae+j+"$"
        //GV_frmname1=Formnae+k+"$"
        }
        octamount=document.getElementById(GV_frmname+"txtoctamt").value
        if(octamount=="")
        {
        octamount=0
        }
      if (document.getElementById(GV_frmname+"txtdockno").value!="")
      {  
      total_octamt=parseFloat(total_octamt)+parseFloat(octamount)
      }
   // alert(total_octamt)
       
    }
    k=j+1
    if(i<10)
        {
            //GV_frmname=Formnae+"0"+j+"$"
            GV_frmname1=Formnae+"0"+k+"$"
        }
        else
        {
       // GV_frmname=Formnae+j+"$"
        GV_frmname1=Formnae+k+"$"
        }
        //alert(GV_frmname1+"txttot")
        //return false;
    //alert(document.getElementById(GV_frmname1+"txttot").value)
    document.getElementById(GV_frmname1+"txttot").value=total_octamt
   // alert(total_octamt)
octamt.value=total_octamt
h1.value=total_octamt
    
    
var vartotdue = Number(txtagnttax.value) + Number(txtothrchg.value) + Number(txtfrmcharg.value) + Number(txtclearchrg.value) + Number(txtsundry.value)
var percentage = 100*Number(txtagnttax.value)/Number(octamt.value)
txtserchgper.value = parseFloat(percentage)

txttotdue.value = Number(vartotdue)+parseFloat(document.getElementById(GV_frmname1+"txttot").value)
h1.value=Number(vartotdue)+parseFloat(document.getElementById(GV_frmname1+"txttot").value)


}
function Nagative_Chk_wDecimal(obj)
{


var temp
temp=obj.value


if (temp=="")
{
alert("Value can not be blank")
obj.focus();
return false;
}
if(isNaN(temp))
{
alert("Value should be Numeric")
obj.value=""
obj.focus();
return false;
}
if(parseFloat(temp)<0)
{
alert("Value should be greater than zero")
obj.value=""
obj.focus();
return false;
}
obj.value=roundit(temp)
return true;
}

 

function roundit(Num)
{
Places=2
if (Places > 0)
{
if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1))
{
if (Num.toString().lastIndexOf('.') < 0)
{
return Num.toString() +'.00';
}
var Rounder = Math.pow(10, Places);
return Math.round(Num * Rounder) / Rounder;
}
else
{
if (Num.toString().lastIndexOf('.') < 0)
{
return Num.toString() +'.00';
}
else
{
if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
return Num.toString() +'0';
else
return Num.toString();

}
}
}
else return Math.round(Num);
}

function tupper(obj)
{
obj.value=obj.value.toUpperCase()
//txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");
}

</script>
    <br />
     
     
     <br />
       <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
          
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:80%"  align="center">
    <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                   Agent Bill Summary
                                    </asp:Label>
                                </td>
                            </tr>
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 111px"><font class="blackfnt">Bill Entry Number</font></td>
        <td style="width: 195px"><font class="blackfnt" color="red" >System Generated...</font></td>
        <td style="width: 188px"><font class="blackfnt">
            <p align="left">
                <font class="blackfnt">Bill date</font>
            </p>
        </font></td>
        <td>
            <asp:TextBox ID="txtbilldt" runat="server" Width="94px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtbilldt"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtbilldt"
                ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator></td>
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Octroi Agent </font></td>
       <td> 
       
                             
                                     <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                                                &nbsp;<asp:DropDownList ID="ddlagnt" runat="server" AutoPostBack="True">
                                                                </asp:DropDownList>
                                    
       </td>
        <td><font class="blackfnt">Agent Bill number</font></td>
        <td>
            <asp:TextBox ID="txtagntbillno" runat="server" Width="91px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidatordd" runat="server" ErrorMessage="*" ControlToValidate="txtagntbillno"></asp:RequiredFieldValidator></td>
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td style="height: 25px"><font class="blackfnt">Octroi paid by agent Rs.</font></td>
       <td style="height: 25px"><font class="blackfnt">
           <asp:TextBox ID="octamt" runat="server" Width="91px" Enabled="False"></asp:TextBox></font></td>
        <td style="height: 25px"><font class="blackfnt">Agent Bill date</font></td>
         <td style="height: 25px">
             <asp:TextBox ID="txtagntbilldt" runat="server" Width="91px"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtagntbilldt"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtagntbilldt"
                 ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator></td>
     </tr>
      <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Agent service charge</font></td>
       <td><font class="blackfnt">
           <asp:TextBox ID="txtagnttax" runat="server" Width="91px" TabIndex="1">0</asp:TextBox></font></td>
        <td><font class="blackfnt">Service Charge(%)</font></td>
         <td>
              <asp:TextBox ID="txtserchgper" runat="server" Width="91px" Enabled="False"></asp:TextBox></td>
     </tr> 
     
       <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Other Charges</font></td>
       <td><font class="blackfnt">
           <asp:TextBox ID="txtothrchg" runat="server" Width="91px" TabIndex="2">0</asp:TextBox></font></td>
        <td><font class="blackfnt">Service Tax charged</font></td>
         <td>
             <asp:TextBox ID="txtservicetxtchrg" runat="server" Width="91px" TabIndex="3">0</asp:TextBox>
             </td>
     </tr>
       <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Form charges</font></td>
       <td><font class="blackfnt">
           <asp:TextBox ID="txtfrmcharg" runat="server" Width="91px" TabIndex="4">0</asp:TextBox></font></td>
        <td><font class="blackfnt">Sundry charges</font></td>
         <td>
             <asp:TextBox ID="txtsundry" runat="server" Width="91px" TabIndex="5">0</asp:TextBox>
             </td>
     </tr>
       <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Clearance charges</font></td>
       <td><font class="blackfnt">
           <asp:TextBox ID="txtclearchrg" runat="server" Width="91px" TabIndex="6">0</asp:TextBox></font></td>
        <td></td>
         <td>
             &nbsp;</td>
     </tr>
       <tr  bgcolor="white" style="height:25px">
      <td style="height: 25px"><font class="blackfnt">Total Due<asp:HiddenField ID="h1" runat="server" />
          </font></td>
       <td style="height: 25px"><font class="blackfnt">
           <asp:TextBox ID="txttotdue" Enabled="false" runat="server" Width="91px">0</asp:TextBox></font>
           <asp:RequiredFieldValidator ID="RequiredFieldValidatorttrr" runat="server" ErrorMessage="*" ControlToValidate="txttotdue"></asp:RequiredFieldValidator></td>
        <td style="height: 25px"><font class="blackfnt">Due date</font></td>
         <td style="height: 25px">
             <asp:TextBox ID="txtduedate" runat="server" Width="91px" TabIndex="7"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidatogggg" runat="server" ErrorMessage="*" ControlToValidate="txtduedate"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtduedate"
                 ErrorMessage="MM/DD/YY" SetFocusOnError="True" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator></td>
     </tr>
         
     </table>
    &nbsp;<br />
                    <center>
                         <table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr bgcolor="white">
               <td align="left" style="width: 91px; height: 40px;" ><font class="bluefnt">
                   Enter Row No *</font></td><td style="height: 40px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></center>
                     <center>
                         &nbsp;</center>
                     <center>
                         <%--<asp:GridView id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />--%>
                        
                         
                         <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white"
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1">
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                 
                                                                  <asp:TemplateField HeaderText="Docket Number  " >
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="True"  Width="100px" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" Width="150px" />
                                                                                <ItemTemplate>
                                    
                                                                                       <asp:TextBox ID="txtdockno" runat="server" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="OnDocketNOChange" ></asp:TextBox>
                                                                                       
                                                                                        <%--<asp:TextBox ID="txtddd" runat="server"   Visible="false" ></asp:TextBox>--%>
                                                                                       
                                                                                    </ItemTemplate>
                                                                                      <FooterTemplate>
                                                                                      <asp:Label ID="lblttt" CssClass="blackfnt"  runat="server">Total : </asp:Label>
                                                                                   
                                                                              </FooterTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderText="Octroi Amount  ">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                     <asp:TextBox ID="txtoctamt" Width="150" runat="server" BorderStyle="Groove"  Columns="8"    ></asp:TextBox>				<%--OnTextChanged="OnAmtChg" AutoPostBack="true" --%>		              
                                                                                     <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtoctamt"></asp:RequiredFieldValidator>--%>
                                                                                    <%-- <asp:RegularExpressionValidator id="reg1" runat="server" ValidationExpression="0-9" ControlToValidate="txtoctamt"></asp:RegularExpressionValidator>--%>
                                                                                      </ItemTemplate>
                                    
                                                                              <FooterTemplate>
                                                                                     <asp:TextBox ID="txttot" Width="150" runat="server" BorderStyle="Groove" Enabled="false"  Columns="8"     ></asp:TextBox>						            
                                                                              
                                                                              </FooterTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                     <asp:TemplateField HeaderText="Octroi receipt no.">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                       <asp:TextBox ID="txtrcpno" Width="150" runat="server" BorderStyle="Groove" Columns="8" ></asp:TextBox>
                                                                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtrcpno"></asp:RequiredFieldValidator>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                            <asp:TemplateField HeaderText="Receipt date (MM/DD/YY)">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtrcpdt" Width="150" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtrcpdt"></asp:RequiredFieldValidator>--%>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtrcpdt"
                ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle CssClass="bgbluegrey" />
                                                                                            </asp:GridView>
                                                                                   
                                                                                    
                                                                                    
                                                                 
                                                                          




				        
				     
				      &nbsp;</center>
                     <center>
                         <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Remark"></asp:Label> 
                          <asp:TextBox ID="txtremarks" runat="server" Height="49px" TextMode="MultiLine"
                             Width="381px" TabIndex="8"></asp:TextBox>
                         </center>
              </ContentTemplate>   
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
              </Triggers>
        
               
            </asp:UpdatePanel>
    <br />
    <br />
                  <br />
                  <center>
            <asp:Button ID="Button11"  runat="server" Text="Submit" OnClick="Button11_Click" TabIndex="9"  /></center>
    </asp:Content>
