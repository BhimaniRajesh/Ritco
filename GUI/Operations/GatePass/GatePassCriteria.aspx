<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GatePassCriteria.aspx.cs" Inherits="GUI_Operations_GatePass_GatePassCriteria"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
<script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript">
        	var cal = new CalendarPopup("testdiv1"); 
	        cal.setCssPrefix("TEST");
	        cal.showNavigationDropdowns();
	        
	 function leftPad(n, len) 
	 {   
           return (new Array(len - String(n).length + 1)).join("0").concat(n);   
     }    
     
	 function btnsubmitClick()
	 {
	    var optdate=document.getElementById("ctl00_MyCPH1_optdate");
	    var optdockno=document.getElementById("ctl00_MyCPH1_optdockno");
	    var optgpnos=document.getElementById("ctl00_MyCPH1_optgpnos");
	    
	    if(optdate.checked==false && optdockno.checked==false && optgpnos.checked==false )
	    {
	        alert("Please Select any one Option");
	        return false;
	    }
	    
	    if(optdate.checked==true)
	    {
	        var txtstart=document.getElementById("ctl00_MyCPH1_txtDateFrom");
	        var txtend=document.getElementById("ctl00_MyCPH1_txtDateTo");
	        var txtpartycode=document.getElementById("ctl00_MyCPH1_txtpartycode");
	        
	        if(txtstart.value=="")
	        {
	            alert("Please Enter Start Date");
	            txtstart.focus();
	            return false;
	        }
	         
	        if(txtend.value=="")
	        {
	            alert("Please Enter End Date");
	            txtend.focus();
	            return false;
	        }
	        
	        if(!isValidDate(txtstart.value," Start Date "))
	        {
	            txtstart.value="";
	            txtstart.focus();
	            return false;
	        }

	        if(!isValidDate(txtend.value," End Date "))
	        {
	            txtend.value="";
	            txtend.focus();
	            return false;
	        }
	    }
	    
	    if(optgpnos.checked==true)
	    {
	        var txtgatepass=document.getElementById("ctl00_MyCPH1_txtgatepass");
	        if(txtgatepass.value=="")
	        {
	            alert("Please Enter GatePass No");
	            txtgatepass.focus();
	            return false;
	        }
	    }
	    
	 
	    if(optdockno.checked==true)
	    {
	        var txtdocknos=document.getElementById("ctl00_MyCPH1_txtdocknos");
	        if(txtdocknos.value=="")
	        {
	            alert("Please Enter <%=dockname %> No");
	            txtdocknos.focus();
	            return false;
	        }
	    }
	    return true;
	 }       
	 
	 
	 
	 function dispDate()
    {
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var daterange = document.getElementById("ctl00_MyCPH1_radDate_0");
        var datelastweek = document.getElementById("ctl00_MyCPH1_radDate_1");
        var datetoday = document.getElementById("ctl00_MyCPH1_radDate_2");
        var datetilldate = document.getElementById("ctl00_MyCPH1_radDate_3");
        var hdnserverdate = document.getElementById("ctl00_MyCPH1_hdnserverdate");
        
         var txtfrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
         var txtto=document.getElementById("ctl00_MyCPH1_txtDateTo");
        
        if(datelastweek.checked==true)
        {
             var arrserverdate=hdnserverdate.value.split('/');
             var dtserverdate = new Date(months[parseInt(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
             var olddate = new Date(months[parseInt(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
             olddate.setDate(olddate.getDate()-6);
             txtfrom.value= leftPad(olddate.getDate(),2) + "/" + leftPad(parseInt(parseInt(olddate.getMonth())+1),2) + "/" + olddate.getFullYear();
             txtto.value=leftPad(dtserverdate.getDate(),2) + "/" + leftPad(parseInt(parseInt(dtserverdate.getMonth())+1),2) + "/" + dtserverdate.getFullYear();
            
        }
        else if(datetoday.checked==true)
        {
             var arrserverdate=hdnserverdate.value.split('/');
             var dtserverdate = new Date(months[parseFloat(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
             txtfrom.value= leftPad(dtserverdate.getDate(),2) + "/" + leftPad(parseInt(parseInt(dtserverdate.getMonth())+1),2) + "/" + dtserverdate.getFullYear();
             txtto.value=leftPad(dtserverdate.getDate(),2) + "/" + leftPad(parseInt(parseInt(dtserverdate.getMonth())+1),2) + "/" + dtserverdate.getFullYear();
        }
        else if(datetilldate.checked==true)
        {
                var arrserverdate=hdnserverdate.value.split('/');
                var dtserverdate = new Date(months[parseFloat(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
                txtfrom.value= "01/01/2004";
                txtto.value=leftPad(dtserverdate.getDate(),2) + "/" + leftPad(parseInt(parseInt(dtserverdate.getMonth())+1),2) + "/" + dtserverdate.getFullYear();
        }
        return true;
    }
    </script>

    <br />
    <asp:Table runat="server" CellSpacing="1" BorderWidth="0" CssClass="boxbg">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Center">Gate Pass Update Criteria</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Width="100px" RowSpan="2" HorizontalAlign="Center" VerticalAlign="Middle">
            <asp:RadioButton ID="optdate" Checked="true" runat="server" GroupName="grpcri" />
            </asp:TableCell>
            <asp:TableCell Width="100px">Date</asp:TableCell>
            <asp:TableCell>
                <asp:Table runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:RadioButtonList ID="radDate" runat="server" onclick="javascript:return dispDate();" CssClass="blackfnt" ValidationGroup="VGDtFromTo"
                                Width="210px">
                                <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                <asp:ListItem Text=" Today" Value="2"></asp:ListItem>
                                <asp:ListItem Text=" Till Date" Value="3"></asp:ListItem>
                            </asp:RadioButtonList>
                        </asp:TableCell>
                        <asp:TableCell VerticalAlign="Top">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" BorderStyle="Groove" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                        name="anchor1" id="anchor1">
                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0">
                                    </a>(dd/mm/yyyy)
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" BorderStyle="Groove" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateTo,'anchor11','dd/MM/yyyy'); return false;"
                                        name="anchor11" id="anchor11">
                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0">
                                    </a>(dd/mm/yyyy)
                                    <br />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell>Party Name</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtpartycode" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
         <asp:TableRow CssClass="bgwhite">
        <asp:TableCell HorizontalAlign="Center" VerticalAlign="Top">
            <asp:RadioButton ID="optdockno" runat="server" GroupName="grpcri" />
        </asp:TableCell>
            <asp:TableCell><%=dockname %> Number</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtdocknos" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
        <asp:TableCell HorizontalAlign="Center" VerticalAlign="Top">
            <asp:RadioButton ID="optgpnos" runat="server" GroupName="grpcri" />
        </asp:TableCell>
            <asp:TableCell>Gate Pass Number</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtgatepass" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                <asp:Button ID="btnsubmit" runat="server" OnClientClick="javascript:return btnsubmitClick()" CssClass="blackfnt" OnClick="btnsubmit_Click" Text="Submit" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:HiddenField ID="hdnserverdate" runat="server" />
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
