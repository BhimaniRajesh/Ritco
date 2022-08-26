<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_Finance_Fix_Asset_aaaaa" %>
	<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="ums" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    User_CTR_Frm_Name="ctl00$MyCPH1$UCMyPaymentControl1$"
	    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	    var FinYear="<%#Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
				
		if(FinYear_to<10)
		{
		    FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
  
        function ValidateDate(obj)
        {
            if (obj.value!="")
            {        
	            if (isDate(obj.value, obj)==false)
	            {    	
		            obj.focus()
		            return false
	            }
                return true
            }
        }
        var dtCh= "/";
        var minYear="1900";
        var maxYear="2100";
        function DaysArray(n) 
        {
	        for (var i = 1; i <= n; i++) 
	        {
		        this[i] = 31
		        if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
		        if (i==2) {this[i] = 29}
            } 
            return this
        }
        function isDate(dtStr, obj)
        {
	        var daysInMonth = DaysArray(12)
	        var pos1=dtStr.indexOf(dtCh)
	        var pos2=dtStr.indexOf(dtCh,pos1+1)
	        var strDay=dtStr.substring(0,pos1)
	        var strMonth=dtStr.substring(pos1+1,pos2)
	        var strYear=dtStr.substring(pos2+1)
	        strYr=strYear
			var today = new Date();
			var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
	        if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	        if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	        for (var i = 1; i <= 3; i++) {
		        if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	        }
	        month=parseInt(strMonth)
	        day=parseInt(strDay)
	        year=parseInt(strYr)
	        if (pos1==-1 || pos2==-1){
		        alert("The date format should be : dd/mm/yyyy")
		        return false
	        }
	        if (strMonth.length<1 || month<1 || month>12){
		        alert("Please enter a valid month")
		        return false
	        }
	        if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		        alert("Please enter a valid day")
		        return false
	        }
	        if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		        alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		        return false
	        }
	        if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		        alert("Please enter a valid date")
		        return false
	        }
			//var newStr = day+'/'+month+'/'+year
			var newStr = month+'/'+day+'/'+year;
			if (new Date(newStr) > new Date()) {
					alert("Sorry !! You Can't Select Future Date")
					obj.value = "";
					return false
			}
	        return true
        }
	    function Check_All(Grid_Id)
	    {
            var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
            var rows=grid.rows.length;  
            if(document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$ChkAll").checked)
            {
                for(var b=2;b<=rows-1;b++)
                {                
                    if(b<10)
                    {
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                    }
                    else
                    {
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                    }
                    document.getElementById(GV_FRM_NM+"chksrno").checked=true
                }
            }
            else
            {
                for(var b=2;b<=rows-1;b++)
                {
                    if(b<10)
                    {
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                    }
                    else
                    {
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                    }
                    document.getElementById(GV_FRM_NM+"chksrno").checked=false
                }
            }
        }     
        
        var Check_One_On_Submit_Present="N"
        var Check_One_On_Submit_Cleared="N"
        	 
        function On_Submit_Inter_fn(Grid_Id)
	    {         	             
	        var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
            var rows=grid.rows.length;  
            var server_dt="<%#System.DateTime.Now.ToString("dd/MM/yyyy")%>"
            var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
            for(var b=2;b<=rows-1;b++)
            {            
                if(b<10)
                {
                    GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                }
                else
                {
                    GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                }
                if(document.getElementById(GV_FRM_NM+"chksrno").checked)
                {
                    if(Grid_Id=="GV_CHQ_Presented")
	                {
	                    Check_One_On_Submit_Present="Y"
	                }
	                else if(Grid_Id=="GV_CHQ_Cleared")
	                {
	                    Check_One_On_Submit_Cleared="Y"
	                }
                    if (document.getElementById(GV_FRM_NM+"Txt_ClearDate").value=="")
				    {
					    alert( "Cheque Clearance Date Should Not Be Blank !!!")
						document.getElementById(GV_FRM_NM+"Txt_ClearDate").focus();
						return false;
                    }
				    var dt=document.getElementById(GV_FRM_NM+"Txt_ClearDate").value
				    var dt_dd=dt.substring(0,2)
				    var dt_mm=dt.substring(3,5)
				    var dt_yy=dt.substring(6,10)

		            var sdt =server_dt
				    var sdt_dd=sdt.substring(0,2)
				    var sdt_mm=sdt.substring(3,5)
				    var sdt_yy=sdt.substring(6,10)
                                        				        				
                    dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		            server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                                            
                    var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
                    var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				    var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				    FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
                                        				
				    var FinYear_todate_dd=FinYear_todate.substring(0,2)
				    var FinYear_todate_mm=FinYear_todate.substring(3,5)
				    var FinYear_todate_yy=FinYear_todate.substring(6,10)
				    FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
                                        				 
                    if (dt>server_dt)
				    {
					    alert( "Clearance Date should not be greater than today's date !!!")
						document.getElementById(GV_FRM_NM+"Txt_ClearDate").focus();
						return false;
                    }
                }                                
            }         
            return true           
	    }
	    function OnSubmit()
	    {    
	        if(!On_Submit_Inter_fn('GV_CHQ_Presented'))
	             return false;
	        
	        if(!On_Submit_Inter_fn('GV_CHQ_Cleared'))
	            return false;
	        
	        if(Check_One_On_Submit_Cleared=="N" && Check_One_On_Submit_Present=="N")
	        {
	            alert( "PLz Select  Atleast One Record !!!")
                return false;
	        }
			ValidateDate();
	    }
    </script>

    <br />
    <div align="left" style="width: 9.5in;">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="top">
                                <br />
                                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="HeaderDet" runat="server" cellspacing="1" width="600" class="boxbg" align="center">
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt"><b>RO</b></font>
                                        </td>
                                        <td>
                                            <asp:Label ID="Lb_RO" CssClass="blackfnt" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt"><b>LO</b></font>
                                        </td>
                                        <td>
                                            <asp:Label ID="Lb_LO" CssClass="blackfnt" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt"><b>Account</b></font>
                                        </td>
                                        <td>
                                            <asp:Label ID="LB_Bankcode" CssClass="blackfnt" runat="server"></asp:Label>
                                            <asp:HiddenField ID="HndBankAcccode" runat="server" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt"><b>Duration</b></font>
                                        </td>
                                        <td>
                                            <asp:Label ID="Lb_dtaeraneg" CssClass="blackfnt" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table cellspacing="1" width="100%" class="boxbg" align="center" id="TBL_CRI" runat="server">
                        <tr style="background-color: white">
                            <td>
                                <font class="bluefnt"><strong>Balance As per Bank Book</strong>
                            </td>
                            <td align="right">
                                <asp:Label ID="LB_Balance_Amount" runat="server" Text="" CssClass="bluefnt" Style="text-align: Right"
                                    Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <font class="bluefnt"><strong>
                                    <asp:Label ID="lbl_Chq_Issued" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <asp:GridView ID="GV_CHQ_Presented" runat="server" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" Width="100%"
                                    ShowFooter="True" OnRowDataBound="GV_D_OnRowDataBound" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO.">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_CHQ_Presented')" />
                                            </HeaderTemplate>
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>                                                
                                                <asp:HiddenField ID="HdnFlag" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Flag") %>' />
                                                <asp:CheckBox ID="chksrno" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque No">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqno" Text='<%# DataBinder.Eval(Container.DataItem, "Chqno") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqdate" Text='<%# DataBinder.Eval(Container.DataItem, "ChqDate") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Party">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblParty" Text='<%# DataBinder.Eval(Container.DataItem, "Party") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voucher No.">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblVoucherno" Text='<%# DataBinder.Eval(Container.DataItem, "Voucherno") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransdate" Text='<%# DataBinder.Eval(Container.DataItem, "Transdate") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblCredit1" Text='Total Amont' Font-Bold="true" runat="server" CssClass="bluefnt"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCredit" Text='<%# DataBinder.Eval(Container.DataItem, "Credit") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTOtalCredit" Text='' runat="server" Font-Bold="true" CssClass="bluefnt"> </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Clear Date" ItemStyle-Wrap="false">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="Txt_ClearDate" runat="server" Width="70" MaxLength="10" Style="text-align: Left"
                                                    Enabled="true" Text='<%# DataBinder.Eval(Container.DataItem,"chqcleardate") %>' 
                                                    onblur="javascript:return ValidateDate(this);" BorderStyle="Groove"
                                                    CssClass="input">
                                                </asp:TextBox>                                                
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comment" ItemStyle-Wrap="false">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="Txt_Comment" runat="server" Width="100" MaxLength="200" Style="text-align: Left"
                                                    Enabled="true" Text='<%# DataBinder.Eval(Container.DataItem,"comment") %>' 
                                                    onblur="javascript:this.value=this.value.toUpperCase();"
                                                    BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voucher Type">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblVouchertype" Text='<%# DataBinder.Eval(Container.DataItem, "Transtype") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Narration">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblNarration" Text='<%# DataBinder.Eval(Container.DataItem, "Narration") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2" align="right">
                                <font class="blackfnt"><strong>
                                    <asp:Label ID="CR_AMT" runat="server" Text="" CssClass="bluefnt" Style="text-align: Right"
                                        Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <font class="bluefnt"><strong>
                                    <asp:Label ID="lbl_Chq_Recived" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <asp:GridView ID="GV_CHQ_Cleared" runat="server" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" Width="100%"
                                    ShowFooter="True" OnRowDataBound="GV_D_OnRowDataBound1" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_CHQ_Cleared')" />
                                            </HeaderTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                                <asp:HiddenField ID="HdnFlag" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Flag") %>' />
                                                <asp:CheckBox ID="chksrno" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque No">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqno" Text='<%# DataBinder.Eval(Container.DataItem, "Chqno") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqdate" Text='<%# DataBinder.Eval(Container.DataItem, "ChqDate") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Party">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblParty" Text='<%# DataBinder.Eval(Container.DataItem, "Party") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voucher No.">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblVoucherno" Text='<%# DataBinder.Eval(Container.DataItem, "Voucherno") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransdate" Text='<%# DataBinder.Eval(Container.DataItem, "Transdate") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblCredit1" Text='Total Amont' CssClass="bluefnt" Font-Bold="true"
                                                    runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="100px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCredit" Text='<%# DataBinder.Eval(Container.DataItem, "Debit") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTOtalCredit" Text='' runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Clear Date" ItemStyle-Wrap="false">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="Txt_ClearDate" runat="server" Width="70" MaxLength="10" Style="text-align: Left"
                                                    Enabled="true" Text='<%# DataBinder.Eval(Container.DataItem, "chqcleardate") %>' 
                                                    onblur="javascript:return ValidateDate(this);" BorderStyle="Groove"
                                                    CssClass="input">
                                                </asp:TextBox>                                                
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Comment" ItemStyle-Wrap="false">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="Txt_Comment" runat="server" Width="100" MaxLength="200" Style="text-align: Left"
                                                    Enabled="true" Text='<%# DataBinder.Eval(Container.DataItem, "comment") %>' 
                                                    onblur="javascript:this.value=this.value.toUpperCase();"
                                                    BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voucher Type">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblVouchertype" Text='<%# DataBinder.Eval(Container.DataItem, "Transtype") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Narration">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblNarration" Text='<%# DataBinder.Eval(Container.DataItem, "Narration") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left">
                                <font class="bluefnt"><strong>BALANCE AS PER BANK STATEMENT</strong>
                            </td>
                            <td align="right">
                                <font class="bluefnt"><strong>
                                    <asp:Label Style="text-align: Right" ID="DR_AMT" runat="server" Text="" CssClass="bluefnt"
                                        Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left">
                                <font class="bluefnt"><strong>ACCOUNTANT</strong>
                            </td>
                            <td align="Left">
                                <font class="bluefnt"><strong>DGM (ACCOUNTS) </strong>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                    <table align="center" cellspacing="1" width="800" class="boxbg" border="0">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Button ID="btn_submit" Text="Submit" CssClass="blackfnt" OnClick="btn_submit_Click"
                                    OnClientClick="javascript:return OnSubmit()" runat="server" />
									<ums:UserMessage ID="umsg" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
