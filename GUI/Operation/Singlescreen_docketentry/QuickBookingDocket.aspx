<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="QuickBookingDocket.aspx.cs" Inherits="GUI_admin_Extra_QuickBookingDocket" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>
                   

<script type="text/javascript" language="javascript">
var DOC_FLAG=false;

function dateBlur(id)
{
    var txt=document.getElementById(id);
    
    if(txt.value!="")
    {
    if(isValidDate(txt.value,"<%=sdkt_call%>"))
        {
           var yr = parseInt(txt.value.substring(6,10));
           var mon=parseInt(txt.value.substring(3,5));
           
           var finyr=parseInt("<%=START_YEAR %>")
                
           if(finyr==yr)
           {
                if(mon<=3)
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
       }
       else
        return false;//END OF DATE VALIDATION
        
    }  // END OF EMPTY CHECK
}



function docBlur(id)
{
    if(!DOC_FLAG)
        return false;
    var txt=document.getElementById(id);
    var s=txt.value;
    txt.value=s.toUpperCase();

    if(txt.value=="")
        return false;


    var grid=document.getElementById("ctl00_MyCPH1_grvcontrols");
    var rownum=grid.rows.length;
    var num="";

    for(i=2;i<rownum;i++)
    {
        if(i<=9)
           num="0" + i;
        else
           num= "" + i;
           
             var txtdoc=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + num + "_txtdocno");
             
                if(txtdoc.getAttribute('id')!=txt.getAttribute('id')) 
                {
                    if(txtdoc.value==txt.value)
                        {
                            alert("Same <%=sdkt_call%> Number Exists. Please Enter Another <%=sdkt_call%> Numeber... ");
                            txt.select();
                            txt.focus();
                            return false;
                        }
                }            
   }
   
   
   
   

    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=doc&code=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="true")
                       {
                            alert("<%=sdkt_call%> Is not Valid..Enter Proper <%=sdkt_call%>....");
                            txt.select();
                            txt.focus();
                            return false;
                       }
                }
          }
        findobj.send(null);
    }
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
                            txt.focus();
                            txt.select();
                            return false;
                       }
                }
          }
        findobj.send(null);
    }
}


function validateBoxes()
{

    var i=0;
    var chk;
    var rownum="";
    var flag=0;
    
    
    var grid=document.getElementById("ctl00_MyCPH1_grvcontrols");
    var rowlen=grid.rows.length;
    
    for(i=2;i<rowlen;i++)
    {
        if(i<=9)
           rownum="0" + i;
        else
           rownum= "" + i;
           
             chk=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_chkflag");
             var txtdoc=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_txtdocno");
             var txtdocdate=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_txtdocdate");
             
             var txtdelloc=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_txtdelloc");
             var txtpkgs=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_txtpkgs");
             var txtactwt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_txtactwt");
             var txtchgwt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rownum + "_txtchgwt");
             
             if(chk.checked==true)
             {  flag=1;
                if(txtdoc.value=="")                   
                    {
                    alert("UnCheck the Row or Enter <%=sdkt_call%> Number........");
                    txtdoc.focus();
                    return false;
                    }
                    
                if(isValidDate(txtdocdate.value,"<%=sdkt_call%>"))
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
                       
                }else return false;
                
                
                if(txtdelloc.value=="")
                    {
                        alert("Enter Delivery Location Properly....");
                        txtdelloc.focus();
                        return false;
                    }
                
                    
                
                if(txtpkgs.value=="")
                    {
                        alert("Enter No of Packages Properly....");
                        return false;
                    }
                else if(isNaN(txtpkgs.value))
                    {
                        alert("Enter Packages Field Properly.........");
                        txtpkgs.select();
                        txtpkgs.value="0";
                        txtpkgs.focus();return false;
                    }
 
                if(txtactwt.value=="")
                    {
                        alert("Enter Actual Weight....");
                        txtactwt.select();
                        txtactwt.focus();
                        return false;
                    }
                else if(isNaN(txtactwt.value))
                    {
                        alert("Enter Actual Weight Properly.........");
                        txtactwt.value="0";
                        txtactwt.select();
                        txtactwt.focus();return false;
                    }
                    
               if(txtchgwt.value=="")
                    {
                        alert("Enter Charge Weight....");
                        return false;
                    }
                else if(isNaN(txtchgwt.value))
                    {
                        alert("Enter Charge Weight Properly.........");
                        txtchgwt.value="0";
                        txtchgwt.select();
                        txtchgwt.focus();return false;
                    }    
             }
    
    }

    if(flag==0)
        {
            alert("Enter Atleaset One <%=sdkt_call%>");
            return false;
        }
}

function OnDocketlenghtcheck(obj)
	{
       
		dktno=obj.value
		var dktlength=dktno.length;
		var dktlength="<%=dktlength%>";
		if(obj.value!="")
		{
			if(dktno.length!=dktlength)
			{
					alert("<%=sdkt_call %> Number Length should be " + dktlength + " digit !!!");
					obj.select();
					obj.focus();
					DOC_FLAG=false;
					return false;
			}
		}
	    DOC_FLAG=true;
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



function chrgBlur(id)
{

    //var chrg= document.getElementById("ctl00_MyCPH1_txtchgwt");
    var chrg=document.getElementById(id);
    var id2=id.substring(0,(id.length-8));

    var act=document.getElementById(id2+"txtactwt");
    
    var chrgwt=parseFloat(chrg.value);
    var actwt=parseFloat(act.value);
    
        if(chrgwt<actwt)
        {
            alert("Charge Weight Can't be Less Actual Weight..");
            chrg.value="0";
            act.focus();
        }
}

</script>

<div align="center" style="width:9.5in;">

<br /><br />

    <table bgcolor="#808080" border="0" class="boxbg" width="100%">
        <tr bgcolor="#ffffff">
            <td class="bluefnt" align="center"><b>Quick <%=sdkt_call%> Booking</b></td>
        </tr>
    </table>

<br />

    
    
        
    
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="50%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" width="50%">Enter No. of Rows</td>
            <td class="blackfnt" align="left" width="50%">
                <asp:TextBox runat="server" ID="txtnorows" onkeypress="validInt(event)"></asp:TextBox>
                <asp:Button runat="server" Text="Add Rows" OnClick="btnrows_Click" ID="btnrows" />
            </td>
        </tr>
    </table>

<br />

  <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">Document Details</td>
        </tr>

<tr bgcolor="#ffffff">
    <td class="blackfnt" align="left">
           <asp:GridView CssClass="boxbg" runat="server" ID="grvcontrols" AllowPaging="true" width="100%"
                AllowSorting="true" PagerStyle-HorizontalAlign="left"
                BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnRowDataBound="grvcontrols_RowDataBound">
             <Columns>
  
                <asp:TemplateField HeaderText="">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:CheckBox ID="chkflag" runat="server" />
                            </ItemTemplate>
                </asp:TemplateField>
        
                <asp:TemplateField HeaderText="Document No.">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtdocno" Width="80px" runat="server"></asp:TextBox>
                                <br /><asp:Label ID="lblerrordockno" runat="server" Visible="False" CssClass="redfnt" Text=""></asp:Label>
                            </ItemTemplate>
                </asp:TemplateField>
            
                <asp:TemplateField HeaderText="<%=sdkt_call%> Date(dd/mm/yyyy)">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtdocdate" onblur="javascript:return dateBlur(this.getAttribute('id'))" Width="60px" runat="server"></asp:TextBox>
                             
                              <asp:LinkButton runat="server" ID="imgdate" ><img src="../../images/calendar.jpg" alt="cal.gif" border="0" /></asp:LinkButton>
                            </ItemTemplate>
                 </asp:TemplateField>
            
                   <asp:TemplateField HeaderText="Del Loc.">
                     <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtdelloc" Width="40px" runat="server" ></asp:TextBox>
                            </ItemTemplate>
                   </asp:TemplateField>
            
                 <asp:TemplateField HeaderText="Pkgs.">
                     <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtpkgs" style="text-align:right" onkeypress="javascript:return validInt(event)" Width="40px" runat="server" Text="0"></asp:TextBox>
                            </ItemTemplate>
                 </asp:TemplateField>
            
                 <asp:TemplateField HeaderText="Act. Wt.">
                     <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtactwt" style="text-align:right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="40px" runat="server" Text="0"></asp:TextBox>
                            </ItemTemplate>
                 </asp:TemplateField>
                <asp:TemplateField HeaderText="Chg Wt.">
                     <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtchgwt" style="text-align:right" onblur="javascript:return chrgBlur(this.getAttribute('id'))"  onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="40px" runat="server" Text="0"></asp:TextBox>
                            </ItemTemplate>
                 </asp:TemplateField>
            </Columns>
        </asp:GridView>
      </td>
</tr>
<tr bgcolor="#ffffff">
    <td class="blackfnt" align="center">
        <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" ID="btnsubmit"></asp:Button>
    </td>
</tr>     
</table>
<asp:HiddenField ID="validation_chk" runat="server" />
 </div>
<asp:HiddenField ID="hdnrows" runat="server" Value="5" />
 <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</asp:Content>
