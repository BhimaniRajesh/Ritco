<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ViewPrint_Bill_1.aspx.cs" Inherits="GUI_Finance_MR_cancel_MR_Cancellation_1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script type="text/javascript" language="javascript" src="../../../GUI/images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" >
        function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function Check()
        {
           
           var varbillno = document.getElementById('ctl00_MyCPH1_txtbill').value;
           if(varbillno == "")
           {
                alert("Please Enter the Bill Number");
                return false;
           }
        }
        
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2)
        {
            window.open("mr_summ_popup.aspx?mrsno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
         }
        function CustBlur(id)
        {
            var txt=document.getElementById(id);

            if(txt.value=="")
                return false;
            txt.value=txt.value.toUpperCase();
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
                var strpg="CheckExist.aspx?mode=cust&code=" + txt.value + "&sid=" + Math.random();
                findobj.open("GET",strpg,true);
                findobj.onreadystatechange=function()
                {
                    if(findobj.readyState==4 && findobj.status==200)
                    {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Customer Code Is not Valid..Enter Proper Customer Code....");
                            txt.value="";
                            return false;
                       }
                    }
                 }
                findobj.send(null);
            }
        }
        
        function GetXMLHttpObject()
        { 
      var xmlHttp;
      try
        {    
            xmlHttp=new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
        }
      catch (e)
        {
            // Internet Explorer    
            try
              {  
                  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
              }
            catch (e)
              {      
                try
                    {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}
                catch (e)
                    {
                        alert("Your browser does not support AJAX!");        
                        return false;        
                    }      
              }    
         }
         return xmlHttp;  
   }
        
        function billBlur(id)
        {
            
            var txt=document.getElementById(id);

            if(txt.value=="")
                return false;
            txt.value=txt.value.toUpperCase();
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
                var strpg="CheckExist.aspx?mode=bill&code=" + txt.value + "&sid=" + Math.random();
                findobj.open("GET",strpg,true);
                findobj.onreadystatechange=function()
                {
                    if(findobj.readyState==4 && findobj.status==200)
                    {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Bill No Is not Valid..Enter Proper Bill Number....");
                            txt.value="";
                            return false;
                       }
                    }
                 }
                findobj.send(null);
            }
        }
    </script>    
    <div id=div1 align=left>
    <table border="0" cellpadding="0" class="boxbg" cellspacing="0">
        <tr bgcolor="white">
            <td align="left" colspan="5" height="30" style="width: 459px">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                <b>Octroi</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                <b>Receipts</b></font></a> <b>&gt;</b>
            </td>
        </tr>
    </table>


    <asp:UpdatePanel ID="UP1" runat="Server"><ContentTemplate>
<TABLE cellSpacing=1 border=0><TBODY><TR align=center><TD align=center colSpan=3><TABLE style="WIDTH: 100%" class="boxbg" cellSpacing=1 border=0><TBODY><TR class="bgbluegrey"><TD style="HEIGHT: 21px" align=center colSpan=3><asp:Label id="lblQry" runat="server" Font-Bold="true" CssClass="blackfnt">
                                        View & Print Bill 
                                    </asp:Label> </TD></TR><TR style="BACKGROUND-COLOR: white"><TD style="WIDTH: 100px; HEIGHT: 25px" align=left><asp:Label id="lbl" runat="server" CssClass="blackfnt" Text="Bill No :" Width="102px"></asp:Label> </TD><TD style="WIDTH: 100px; HEIGHT: 25px" align=left><asp:TextBox id="txtbill" runat="server"></asp:TextBox> </TD><TD style="HEIGHT: 25px" vAlign=top align=left><asp:Button id="submit2" onclick="submit2_Click" runat="server" Text="Submit"></asp:Button> </TD></TR><TR style="BACKGROUND-COLOR: white"><TD style="HEIGHT: 21px" align=center colSpan=3><asp:Label id="Label1" runat="server" Font-Bold="true" CssClass="blackfnt">
                                        OR
                                    </asp:Label> </TD></TR><TR class="bgbluegrey"><TD style="HEIGHT: 21px" align=center colSpan=3><asp:Label id="Label2" runat="server" Font-Bold="true" CssClass="blackfnt">
                                        Select Bill 
                                    </asp:Label> </TD></TR><TR style="BACKGROUND-COLOR: white"><TD style="WIDTH: 100px; HEIGHT: 25px" align=left><asp:Label id="Label3" runat="server" CssClass="blackfnt" Text="Enter Customer :" Width="102px"></asp:Label> </TD><TD align=left><asp:TextBox id="txtcust" runat="server"></asp:TextBox> <asp:Label id="Label7" tabIndex=18 runat="server" Text='<a href="javascript:nwOpen(1)">...</a>' BorderStyle="Groove" Width="14px"></asp:Label> </TD><TD vAlign=top align=left></TD></TR><TR style="BACKGROUND-COLOR: white"><TD style="WIDTH: 100px; HEIGHT: 25px" align=left><asp:Label id="Label4" runat="server" CssClass="blackfnt" Text="Bill Type :" Width="102px"></asp:Label> </TD><TD style="WIDTH: 100px; HEIGHT: 25px" align=left colSpan=2><asp:DropDownList id="ddlmrtype" runat="server"><asp:ListItem Value="6">OCTROI</asp:ListItem>
</asp:DropDownList> </TD></TR><TR class="bgbluegrey"><TD style="HEIGHT: 21px" align=center colSpan=3><asp:Label id="Label5" runat="server" Font-Bold="true" CssClass="blackfnt">
                                        Select Bill Generation Date Range  
                                    </asp:Label> </TD></TR><TR style="FONT-SIZE: 12pt; FONT-FAMILY: Times New Roman" bgColor=#ffffff><TD vAlign=top align=left><asp:Label id="Label6" runat="server" CssClass="blackfnt" Text="Select Login Date" Width="145px"></asp:Label> </TD><TD style="WIDTH: 359px" vAlign=top align=left><asp:RadioButtonList id="radDate" runat="server" CssClass="blackfnt" Width="244px" ValidationGroup="VGDtFromTo" AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList></TD><TD style="WIDTH: 359px" vAlign=top align=left><asp:Label id="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label> <asp:TextBox id="txtDateFrom" runat="Server" Width="80" ValidationGroup="VGDtFromTo"></asp:TextBox> <A id="alnkDateFrom" onclick="cal.select(ctl00_MyCPH1_txtDateFrom, 'alnkDateFrom', 'dd/MM/yyyy'); return false;" href="#"><IMG alt="" id="calfrom" runat="server" src="../../images/calendar.jpg" border=0 /></A> <asp:Label id="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label> <asp:TextBox id="txtDateTo" runat="Server" Width="80" ValidationGroup="VGDtFromTo"></asp:TextBox> <A id="a1" onclick="cal.select(ctl00_MyCPH1_txtDateTo, 'alnkDateFrom', 'dd/MM/yyyy'); return false;" href="#"><IMG alt="" src="../../../images/calendar.jpg" border=0 id="calTo" runat="server" /> <asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only" OnServerValidate="daterange"></asp:CustomValidator> <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                                                ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
            
                                                                ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator>--%></A></TD></TR><TR style="BACKGROUND-COLOR: white"><TD colSpan=4><asp:Button id="Button1" onclick="submit1_Click" runat="server" Text="Submit"></asp:Button> </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
                                                                
<div id="divDate" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</ContentTemplate>
</asp:UpdatePanel>
                    </div>
               </asp:Content>
