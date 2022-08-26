<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="EditQuickDocket.aspx.cs" Inherits="GUI_admin_Extra_EditQuickDocket" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
</script>
 
<script type="text/javascript" language="javascript">

function update_dockno(dockno)
{
   document.getElementById("ctl00_MyCPH1_txtdocno").value=dockno;
   return false;
}

function openPopUp()
{
    var dktno=document.getElementById("ctl00_MyCPH1_txtdocno").value;
    window.open('popup_docketno.aspx?dockno=' + dktno,null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');
    return false;
}
   
// this function assignment in keypress doesn't allow any character other than number.
function validInt(event)
{
    if(event.keyCode==13)
        {
            return true;
        }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}

// this function assignment in keypress doesn't allow any character other than number and a dot.
function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
}

function validateBoxes()
{

    var i=0;
     var lbldocno=document.getElementById("ctl00_MyCPH1_lbldockno");
     var txtdocdate=document.getElementById("ctl00$MyCPH1$txtdocdate");
     var txtdelloc=document.getElementById("ctl00$MyCPH1$txtdelivery");
     var txtpkgs=document.getElementById("ctl00$MyCPH1$txttotnopack");
     var txtactwt=document.getElementById("ctl00$MyCPH1$txttotactwt");
     var txtchgwt=document.getElementById("ctl00$MyCPH1$txtchrgwt");
             
           
                
                if(isValidDate(txtdocdate.value,"<%=sdkt_call %>"))
                {
                      var yr = parseInt(txtdocdate.value.substring(6,10));
                       var mon=parseInt(txtdocdate.value.substring(3,5));
                       
                       var finyr=parseInt("<%=START_YEAR %>")
                            
                       if(finyr==yr)
                       {
                            if(mon<3)
                                {
                                    alert("Enter Date Within Financial Year " + (finyr) + " TO " + (finyr+1));
                                    txtdocdate.select();
                                    txtdocdate.focus();
                                    return false;
                                }
                       }
                       else if(yr==(finyr+1))
                       {
                            if(mon>3)
                                {
                                    alert("Enter Date Within Financial Year " + (finyr) + " TO " + (finyr+1));
                                    txtdocdate.select();
                                    txtdocdate.focus();
                                    return false;
                                }
                       }
                       else
                       {
                            alert("Enter Date Within Financial Year " + (finyr) + " TO " + (finyr+1));
                            txtdocdate.select();
                            txtdocdate.focus();
                            return false;
                       }
                }
                else {return false;} // END OF DATE VALIDATION
                
                
                     
                if(txtdelloc.value=="")
                    {
                        alert("Enter Delivery Location....");
                        txtdelloc.focus();
                        return false;
                    }
                
               
                if(txtpkgs.value=="")
                    {
                        alert("Enter No of Packages....");
                        txtpkgs.focus();
                        return false;
                    }
                else if(isNaN(txtpkgs.value))
                    {
                        alert("Enter Packages Field Properly.........");
                        txtpkgs.value="0";
                        txtpkgs.focus();
                        return false;
                    }
 
 
                if(txtactwt.value=="")
                    {
                        alert("Enter Actual Weight....");
                        txtactwt.focus();
                        return false;
                    }
                else if(isNaN(txtactwt.value))
                    {
                        alert("Enter Actual Weight Properly.........");
                        txtactwt.value="0";
                        txtactwt.focus();
                        return false;
                    }
                    
               if(txtchgwt.value=="")
                    {
                        alert("Enter Charge Weight....");
                        txtchgwt.focus();
                        return false;
                    }
                else if(isNaN(txtchgwt.value))
                    {
                        alert("Enter Charge Weight Properly.........");
                        txtchgwt.value="0";
                        txtchgwt.focus();
                        return false;
                    }   
                    
                    if(parseInt(txtchgwt.value)<parseInt(txtactwt.value))
                    {
                        alert("Charge Weight Must not Less than actual Weight....");
                        txtchgwt.focus();
                        return false;
                    }
                    
        if(!confirm("Are you Sure you want to update " + lbldocno.value +  " <%=sdkt_call %> ?" ))
            return false;
            
        
                   
}

function dateBlur(id)
{
    var txt=document.getElementById(id);
    if(txt.value!="")
    {
    if(!isValidDate(txt.value,"<%=sdkt_call%>"));
        {
        
           var yr = parseInt(txt.value.substring(6,10));
           var mon = parseInt(txt.value.substring(3,5));
           
           var finyr=parseInt("<%=START_YEAR %>")
                
           if(finyr==yr)
           {
                if(mon<3)
                    {
                        alert("Enter Date Within Financial Year " + (finyr) + " TO " + (finyr+1));
                        txt.select();
                        txt.focus();
                        return false;
                    }
           }
           else if(yr==(finyr+1))
           {
                if(mon>3)
                    {
                        alert("Enter Date Within Financial Year " + (finyr) + " TO " + (finyr+1));
                        txt.select();
                        txt.focus();
                        return false;
                    }
           }
           else
           {
                alert("Enter Date Within Financial Year " + (finyr) + " TO " + (finyr+1));
                txt.select();
                txt.focus();
                return false;
           }
       } //END OF DATE VALIDATION
    } // END EMPTY CHECK
}



function delLocBlur(id)
{
    var txt=document.getElementById(id);
    var s=txt.value;
    txt.value=s.toUpperCase();
    if(txt.value=="")
        return false;

    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=loc&code=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Location Is not Valid..Enter Proper Location Code....");
                            txt.value="";
                            txt.focus();
                            return false;
                       }
                }
          }
        findobj.send(null);
    }
}

</script>

<div align="center" style="width:9.5in;">

<br />
    <table bgcolor="#808080" border="0" class="boxbg" width="80%">
        <tr bgcolor="#ffffff">
            <td class="bluefnt" align="center">
                <b>Edit Quick <%=sdkt_call %> Booking</b></td>
        </tr>
    </table>
<br />

 
  <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="80%">
      <tr class="bgbluegrey">
          <td class="blackfnt" align="center">Document Details</td>
      </tr>
      <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt"><%=sdkt_call %> No.: 
              <asp:TextBox ID="txtdocno" runat="server"></asp:TextBox>
              <asp:Button ID="btnpopup" OnClientClick="javascript:return openPopUp()" runat="server" Text=".." />
              <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" runat="server" Text="Submit" /><strong><u>e.g.</u></strong>100000
          </td>
      </tr>
      <tr bgcolor="#ffffff">
        <td align="left" class="blackfnt"><strong>N.B.</strong><u>Search <%=sdkt_call %> by typing initial characters of <%=sdkt_call %> No and click on '..'</u></td>
      </tr>
</table>
<br />
 <asp:Panel ID="divexcept" runat="server" style="display:none;">
          <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="80%">
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center">Exception Occoured</td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="redfnt">
                        No Such <%=sdkt_call %> was Found.<br /><strong>OR</strong><br /><%=sdkt_call %> is not eligible for Edit purpose.
                    </td>
                </tr>
          </table>
    </asp:Panel>  
    <br /><br />
    <asp:Panel ID="divedit" style="display:none;" runat="server">

        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="80%">
                <tr class="bgbluegrey">
                    <td class="blackfnt" colspan="4" align="center"><strong><%=sdkt_call %> Summary</strong></td>
                </tr>
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center"><%=sdkt_call %> Number</td>
                    <td class="blackfnt" align="center"><%=sdkt_call %> Date</td>
                    <td class="blackfnt" align="center">Origin</td>
                    <td class="blackfnt" align="center">Dely.</td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" align="center">
                        <asp:Label ID="lbldockno" Font-Bold="true" CssClass="bluefnt" runat="server"></asp:Label>
                    </td>
                    <td class="blackfnt" align="center">
                        <asp:TextBox ID="txtdocdate" Width="60px" onblur="javascript:dateBlur(this.getAttribute('id'))" runat="server"></asp:TextBox>
                         <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtdocdate,'anchor1','dd/MM/yyyy'); return false;" name="anchor1" id="a1" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                         </a> (dd/mm/yyyy)
                    </td>
                    <td class="blackfnt" align="center">
                        <asp:Label ID="lblorigin" runat="server"></asp:Label>
                    </td>
                    <td class="blackfnt" align="center">
                        <asp:TextBox ID="txtdelivery" style="text-align:center;" Width="40px" runat="server"></asp:TextBox>
                    </td>
                </tr>
        </table>
<br />

         <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="80%">
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center" colspan="2"><strong>Consignment Details</strong></td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" width="30%" align="left">Total No. of Packages.</td>
                    <td class="blackfnt" align="left">
                        <asp:TextBox ID="txttotnopack" onkeypress="javascript:return validInt(event,this.getAttribute('id'))" style="text-align:right;" Width="60px" runat="server"></asp:TextBox>
                        <asp:Label ID="lbltotnopack" CssClass="bluefnt" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" width="30%" align="left">Total Actual Weight. (Kg.)</td>
                    <td class="blackfnt" align="left">
                        <asp:TextBox ID="txttotactwt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="text-align:right;" Width="60px" runat="server"></asp:TextBox>
                        <asp:Label ID="lbltotactwt" CssClass="bluefnt" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" width="30%" align="left">Charged Wight (Kg.)</td>
                    <td class="blackfnt" align="left">
                        <asp:TextBox ID="txtchrgwt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="text-align:right;" Width="60px" runat="server"></asp:TextBox>
                        <asp:Label ID="lblchrgwt" CssClass="bluefnt" runat="server"></asp:Label>
                    </td>
                </tr>
          </table>
<br />
        <table cellpadding="3" cellspacing="1" class="boxbg" width="80%">
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center">
                        <asp:Button ID="btneditsubmit" Text="Submit" runat="server" OnClick="btneditsubmit_Click" />
                    </td>
                </tr>
        </table>
    </asp:Panel>
    
 </div>

 <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</asp:Content>
