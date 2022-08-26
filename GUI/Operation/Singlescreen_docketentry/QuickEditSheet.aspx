<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="QuickEditSheet.aspx.cs" Inherits="GUI_admin_Extra_QuickEditSheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
                   
                              <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="../viewnprint/ViewPrint.js"></script>



<script language ="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
function ticTac(chk)
{
     if(chk.checked==true)
         document.getElementById("ctl00$MyCPH1$txtflaglocalcn").value="Y";
     else     
         document.getElementById("ctl00$MyCPH1$txtflaglocalcn").value="N";
}   
</script>



<br /><br />
    

 <div align="center">
 
    <table border="0" cellpadding="3" cellspacing="1" width="90%">
        <tr>
            <td class="blackfnt" align="left"><u><b>Note :</b></u><br />Fields marked with <font color="red">*</font> are compulsary.</td>
        </tr>
    </table>
    <br />
 
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
        <tr class="bgbluegrey">
            <td class="bluefnt" align="center"><u><b>C.NOTE - INFORMATION</b></u></td>
        </tr>
    </table>
 <br />
 
  <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
      <tr class="bgbluegrey">
          <td class="blackfnt" colspan="6" align="center">C.NOTE Details</td>
      </tr>
      <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt"><font color="red">*</font>C.Note Number</td>
          <td align="left" class="blackfnt">
                <asp:Label ID="lblcnoteno" runat="server"></asp:Label>
          </td>
          <td align="left" class="blackfnt"><font color="red">*</font>C.Note Date</td>
          <td align="left" class="blackfnt">
                <asp:TextBox ID="txtcnotedate" Width="60px" runat="server"></asp:TextBox>
                 <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtcnotedate,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="a1" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                 </a> (dd/mm/yyyy)
          </td>
          <td align="left" class="blackfnt">Payment Type</td>
          <td align="left" class="blackfnt">
                <asp:DropDownList ID="cmbpaytype" runat="server">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem>BOD</asp:ListItem>
                    <asp:ListItem>FOC</asp:ListItem>
                    <asp:ListItem>NATIONAL</asp:ListItem>
                    <asp:ListItem>Paid</asp:ListItem>
                    <asp:ListItem>TBB</asp:ListItem>
                    <asp:ListItem>To Pay</asp:ListItem>
                </asp:DropDownList>
          </td>
      </tr>
      <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt">Billing Party</td>
          <td align="left" class="blackfnt">
                <asp:TextBox ID="txtbillingparty" runat="server"></asp:TextBox>
                <asp:Button ID="btnpartypopup" Text="..." runat="server" />
          </td>
          <td align="left" class="blackfnt">Origin</td>
          <td align="left" class="blackfnt">
                <asp:TextBox ID="txtorigin" runat="server"></asp:TextBox>
                <asp:Button ID="btnoriginpopup" Text="..." runat="server" />
          </td>
          <td align="left" class="blackfnt"><font color="red">*</font>Destination</td>
          <td align="left" class="blackfnt">
                <asp:TextBox ID="txtdest" runat="server"></asp:TextBox>
                <asp:Button ID="btndestpopup" Text="..." runat="server" />
          </td>
      </tr>
      <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt"><font color="red">*</font>PickUp/Delivery</td>
          <td align="left" class="blackfnt">
               <asp:DropDownList ID="cmbpickup" runat="server">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem>Godown PickUp - Godown Delivery</asp:ListItem>
                    <asp:ListItem>Godown PickUp - Door Delivery</asp:ListItem>
                    <asp:ListItem>Door PickUp - Door Delivery</asp:ListItem>
                    <asp:ListItem>Door PickUp - Godown Delivery</asp:ListItem>
                </asp:DropDownList>
          </td>
          <td align="left" class="blackfnt">From</td>
          <td align="left" class="blackfnt">
                <asp:TextBox ID="txtfrom" runat="server"></asp:TextBox>
                <asp:Button ID="btnfrompopup"  Text="..." runat="server" />
          </td>
          <td align="left" class="blackfnt">To</td>
          <td align="left" class="blackfnt">
                <asp:TextBox ID="txtto" runat="server"></asp:TextBox>
                <asp:Button ID="btnto" Text="..." runat="server" />
          </td>
      </tr>
      <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt">Volumetric</td>
          <td align="left" class="blackfnt">
                <asp:CheckBox ID="chkvolumetric" runat="server"/>
          </td>
          <td align="left" class="blackfnt">COD/DOD</td>
          <td align="left" class="blackfnt">
                <asp:CheckBox ID="chkcoddod" runat="server"/>
          </td>
          <td align="left" class="blackfnt">ODA</td>
          <td align="left" class="blackfnt">
                <asp:CheckBox ID="chkoda" runat="server"/>
          </td>
      </tr>
      <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt">Local CN</td>
          <td align="left" class="blackfnt">
                <asp:CheckBox ID="chkflaglocalcn" runat="server" />
                <asp:TextBox ID="txtflaglocalcn" Width="50"  Text="N" Enabled="False" runat="server"></asp:TextBox>
          </td>
          <td align="left" class="blackfnt"></td>
          <td align="left" class="blackfnt">
          
          </td>
          <td align="left" class="blackfnt"></td>
          <td align="left" class="blackfnt">
          
          </td>
      </tr>
</table>
<br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
      <tr bgcolor="#ffffff">
          <td align="left" colspan="2" class="blackfnt"><strong>Consignor</strong></td>
          <td align="left" colspan="2" class="blackfnt"><strong>Consignee</strong></td>
          <td align="left" colspan="2" class="blackfnt"><strong>Document</strong></td>
      </tr>
      <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Code</td>
            <td align="left" class="blackfnt"><font color="red">*</font>Enter From Existing Consigner<br />
                <asp:TextBox ID="txtconocode1" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtconocode2" runat="server"></asp:TextBox>
                <asp:Button ID="btnconopopup" Text="..." runat="server" />
            </td>
            <td align="left" class="blackfnt"><font color="red">*</font>Enter From Existing Consignee<br />
                <asp:TextBox ID="txtconecode1" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtconecode2" runat="server"></asp:TextBox>
                <asp:Button ID="bntconepopup" Text="..." runat="server" />
            </td>
            <td align="left" class="blackfnt">Risk Type : </td>
            <td align="left" class="blackfnt">
                <asp:RadioButton ID="optcarrierrisk" GroupName="grprisk" runat="server" Text="Carrier's Risk" />
            </td>
            <td align="left" class="blackfnt">
                <asp:RadioButton ID="optownerrisk" GroupName="grprisk" runat="server" Text="Owner's Risk" />
            </td>
      </tr>
      <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt"><font color="red">*</font>Name</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtcononame" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconename" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">Internal Covers</td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:TextBox ID="txtintercover" runat="server"></asp:TextBox>
            </td>
      </tr>
      <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt"><font color="red">*</font>Address</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconoadd" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconeadd" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">Modavat Covers</td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:CheckBox ID="chkmodvatcov" runat="server" />
                <asp:TextBox ID="txtmodvatcov"  runat="server"></asp:TextBox>
            </td>
      </tr>
      <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt"><font color="red">*</font>City</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconocity" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconecity" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">Modavat Covers</td>
            <td align="left" class="blackfnt">Customer ref.</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtcustref" runat="server"></asp:TextBox>
            </td>
      </tr>
      <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Telephone</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconotel" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconetel" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt" colspan="2">Private Mark</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtprivatemark" runat="server"></asp:TextBox>
            </td>
      </tr>
      <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Email</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconoemail" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtconeemail" runat="server"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt">TP Number</td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:TextBox ID="txttpnumber" runat="server"></asp:TextBox>
            </td>
      </tr>
    </table>
    
    <br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
      <tr class="bgbluegrey">
          <td align="center" colspan="4" class="blackfnt"><strong>Document Details</strong></td>
      </tr>
      <tr bgcolor="#ffffff">
        <td align="left" class="blackfnt">Document Name</td>
        <td align="left" class="blackfnt">Required</td>
        <td align="left" class="blackfnt">Apllicable in State</td>
        <td align="left" class="blackfnt"><font color="red">*</font>Enclosed Document Number</td>
      </tr>
      <tr bgcolor="#ffffff">
        <td align="left" class="blackfnt">KGST No.</td>
        <td align="left" class="blackfnt">
            <asp:Label ID="lblkgstreq" runat="server"></asp:Label>
        </td>
        <td align="left" class="blackfnt">
            <asp:Label ID="lblkgstappl" runat="server"></asp:Label>
        </td>
        <td align="left" class="blackfnt">
            <asp:TextBox ID="txtkgstenclosedoc" runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr bgcolor="#ffffff">
        <td align="left" class="blackfnt">TIN No.</td>
        <td align="left" class="blackfnt">
            <asp:Label ID="lbltinreq" runat="server"></asp:Label>
        </td>
        <td align="left" class="blackfnt">
            <asp:Label ID="lbltinappl" runat="server"></asp:Label>
        </td>
        <td align="left" class="blackfnt">
            <asp:TextBox ID="txttinenlosedoc" runat="server"></asp:TextBox>
        </td>
      </tr>
    </table>

    <br /><br />

      <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
          <tr class="bgbluegrey">
            <td align="center" colspan="6" class="blackfnt"><strong>Permit Tracker</strong></td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Permit Applicatble</td>
            <td align="left"  class="blackfnt">
                <asp:CheckBox ID="chkperapp" runat="server" />  
            </td>
            <td align="left" class="blackfnt">Permit Recieved At</td>
            <td align="left"  class="blackfnt">
                <asp:DropDownList ID="cmbpermitrecat" runat="server">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem>Booking</asp:ListItem>
                    <asp:ListItem>Delivery</asp:ListItem>
                </asp:DropDownList>
            </td>            
            <td align="left" class="blackfnt">Permit No.</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtpermitno" runat="server"></asp:TextBox>
            </td>
          </tr>
          
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Permit Date</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtpermitdate" Width="60px" runat="server"></asp:TextBox>
                <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtpermitdate,'ankpermitdate','dd/MM/yyyy'); return false;"  name="ankpermitdate" id="a2" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                </a> (dd/mm/yyyy)
            </td>
            <td align="left" class="blackfnt">Permit Validity Date</td>
            <td align="left" class="blackfnt">
                 <asp:TextBox ID="txtpermitvaldate" Width="60px" runat="server"></asp:TextBox>
                 <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtpermitvaldate,'ankpermitval','dd/MM/yyyy'); return false;"  name="ankpermitval" id="a3" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                </a> (dd/mm/yyyy)
            </td>            
            <td align="left" class="blackfnt">Permit Recieved Date</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtpermitrecdate" Width="60px" runat="server"></asp:TextBox>
                <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtpermitrecdate,'ankpermitrec','dd/MM/yyyy'); return false;"  name="ankpermitrec" id="a4" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                </a> (dd/mm/yyyy)
            </td>
          </tr>
      </table>

<br />
      <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
          <tr class="bgbluegrey">
            <td align="center" class="blackfnt">Enter No of Rows.
                <asp:TextBox ID="txtnorows" runat="server"></asp:TextBox>
            </td>
          </tr>
      </table>
<br />

    <asp:Table ID="tblinvoice" runat="server">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell CssClass="blackfnt" ColumnSpan="5">InVoice Details</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow BackColor="#ffffff">
            <asp:TableCell CssClass="blackfnt">InVoice No.</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">InVoice Date</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">Declared Value</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">No. of Pkgs.</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">Actual Weight</asp:TableCell>
        </asp:TableRow>
        
        <asp:TableRow BackColor="#ffffff">
            <asp:TableCell CssClass="blackfnt"></asp:TableCell>
            <asp:TableCell CssClass="blackfnt">(dd/mm/yyyy)</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">(Rs.)</asp:TableCell>
            <asp:TableCell CssClass="blackfnt"></asp:TableCell>
            <asp:TableCell CssClass="blackfnt">(Kg.)</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    
    <br />
    
      <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
          <tr class="bgbluegrey">
            <td align="center" colspan="6" class="blackfnt"><strong>Consignment Details</strong></td>
          </tr>
          
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Total No of Packages</td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txttotnopack" runat="server" ></asp:TextBox>
            </td>
            <td align="left" class="blackfnt"><font color="red">*</font>Packaging Type</td>
            <td align="left" class="blackfnt" colspan="3">
                <asp:DropDownList ID="cmbpacktype" runat="server">
                </asp:DropDownList>
            </td>
          </tr>
          
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Total Actual Weight (Kg.)</td>
            <td align="left"  class="blackfnt">
                <asp:TextBox ID="txttotactwt" runat="server" ></asp:TextBox>
            </td>
            <td align="left"  class="blackfnt"><font color="red">*</font>Say to Contain (Product)</td>
            <td align="left"  class="blackfnt"colspan="3">
                <asp:DropDownList ID="cmbsaytocontain" runat="server">
                </asp:DropDownList>
            </td>
          </tr>
            
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt"><font color="red">*</font>Charged Weight (Kg.)</td>
            <td align="left"  class="blackfnt">
                <asp:TextBox ID="txtchrgwt" runat="server" ></asp:TextBox>
            </td>
            <td align="left"  class="blackfnt">Special Instructions</td>
            <td align="left"  class="blackfnt" colspan="3">
                
            </td>
          </tr>
          
           <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt"><font color="red">*</font>Mode</td>
            <td align="left"  class="blackfnt">
                <asp:DropDownList ID="cmbmode" runat="server">
                    <asp:ListItem>Air</asp:ListItem>
                    <asp:ListItem>Road</asp:ListItem>
                    <asp:ListItem>Train</asp:ListItem>
                    <asp:ListItem>Express</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="left"  class="blackfnt"><font color="red">*</font>Service Type</td>
            <td align="left"  class="blackfnt">
                 <asp:DropDownList ID="cmbservicetype" runat="server">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem>SUNDRY</asp:ListItem>
                    <asp:ListItem>FTL</asp:ListItem>
                 </asp:DropDownList>
            </td>
             <td align="left" class="blackfnt"><font color="red">*</font>Type of FTL</td>
            <td align="left"  class="blackfnt">
                    <asp:DropDownList ID="cmbftl" runat="server">
                    </asp:DropDownList>
            </td>
          </tr>
          
          <tr bgcolor="#ffffff">
            <td align="left"  class="blackfnt" colspan="6">
                EDD<asp:TextBox ID="txtedd" Width="60px" runat="server"></asp:TextBox>
                <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtedd,'ankedd','dd/MM/yyyy'); return false;"  name="ankedd" id="a5" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                </a> (dd/mm/yyyy)
            </td>
          </tr>
          
      </table>
    
 </div>
   <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</asp:Content>
