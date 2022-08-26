<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ForwardFMDocumentsMain_new.aspx.cs" Inherits="GUI_Operations_FM_ForwardFMDocumentsMain_new" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
    </script>

    <script type="text/javascript" language="javascript">
        function fsubmit12()
	    {
            var ddlFwdDocTo=document.getElementById("ctl00_MyCPH1_ddlFwdDocTo");
            var ddlDocType=document.getElementById("ctl00_MyCPH1_ddlDocType");
            if(ddlDocType.value=="")
            {
                alert("Please Doc Type!!!")
                ddlDocType.focus();
                return false;                
            }
            return DateCheck();
        }
        function OpenPopupWindow(strDocketNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "./ViewFMScannedDocument.aspx?DocName=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        var months = new Array("","January", "February", "March", "April", "May", "June",
	                           "July", "August", "September", "October", "November", "December");
            
        function fsubmit()
        {
    	
	        ///debugger 
	         var ddlFwdDocTo=document.getElementById("ctl00_MyCPH1_ddlFwdDocTo");
	         var ddlCustomerLocation=document.getElementById("ctl00_MyCPH1_ddlCustomerLocation");
	         var ddlCustomerLocation=document.getElementById("ctl00_MyCPH1_ddlCustomerLocation");
	         var txtCourier=document.getElementById("ctl00_MyCPH1_txtCourier");
	         var txtWayBillNo=document.getElementById("ctl00_MyCPH1_txtWayBillNo");
	         var txtWayBillDate=document.getElementById("ctl00_MyCPH1_txtWayBillDate");
	         var txtFMDate=document.getElementById("ctl00_MyCPH1_txtFMDate");
	         if(txtFMDate.value=="")
	        {
		        alert("Please Enter FM Date!!!")
		        txtFMDate.focus();
		        return false;
	        }
	        
	        if(ddlFwdDocTo.value=="")
	        {
		        alert("Please Select Forward Document To!!!")
		        ddlFwdDocTo.focus();
		        return false;
	        }
        	       	
        	
	        if(ddlCustomerLocation.value=="")
	        {
		        alert("Please Select Customer /Location !!!")
		        ddlCustomerLocation.focus();
		        return false;
	        }
        	 
	        if(txtCourier.value=="")
	        {
		        alert("Please Enter Courier!!!")
		        txtCourier.focus();
		        return false;
	        }
        	
	        if(txtWayBillNo.value=="")
	        {
		        alert("Please Enter Way BillNo!!!")
		        txtWayBillNo.focus();
		        return false;
	        }
        	
	        if(txtWayBillDate.value=="")
	        {
		        alert("Please Enter Way BillDate!!!")
		        txtWayBillDate.focus();
		        return false;
	        }
        	
	        var dt =txtWayBillDate.value
			        //alert(dt)
	        var dt_dd=dt.substring(0,2)
        	
	        var dt_mm=dt.substring(3,5)
	        var dt_yy=dt.substring(6,10)
		        //alert(" hi .." + dt)
	        bgndt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	        //alert(bgndt)
        			
	        currdate="<%=currdate %>"
	        dt_dd=currdate.substring(0,2)
	        dt_mm=currdate.substring(3,5)
	        dt_yy=currdate.substring(6,10)
	        //alert("hi")
	        currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
        		
	        //alert(currdate)
	        if (currdate < bgndt)
	        {
			        alert("Bill Date should be less than or equal to  system Date \n")
			        txtWayBillDate.focus();
			        return false;
	        }
	        //debugger
        	
	        var GV_frmname="ctl00_MyCPH1_dgDocket_";
            var GV=document.getElementById("ctl00_MyCPH1_dgDocket");
            var r=GV.rows.length;

            var pref="";
            var chkcount=0;
            for(var i=2;i<r+1;i++)
            {
                if(i<10)
                     pref=GV_frmname + "ctl0" + i + "_";
                else
                 pref=GV_frmname + "ctl" + i + "_";

                var chk=document.getElementById(pref + "chkOrderNo");
                if(chk.checked==true)
                {
                    chkcount++; 
                }
          
            }            
	        if(chkcount==0)
            {
                alert("No Row Selected..........");
                return false;
            }                        
                        
            click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);

            if(click_count > 0)
		    {
			    alert("Sorry... You cannot click twice !!!")
			    return false;
		    }  
		    else
		    {
			    click_count=click_count+1
			    document.getElementById("ctl00_MyCPH1_click_count").value=click_count
	        } 
	        alert("Submitted To prepare PFM.....")
    	
	    }
            
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:HiddenField ID="click_count" Value="0" runat="server" />
    <br />
    <table border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                    class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                    <strong>Forward Documents</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10" /></td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td height="300" valign="top">
                <table border="0" class="boxbg" align="center" cellspacing="1" cellpadding="1" style="width: 8.5in">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="4" style="height: 30px;">
                            <label class="blackfnt">
                                <b>FM Query </b>
                            </label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                Select Document Type:
                            </label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlDocType" runat="server" AutoPostBack="true" CssClass="input"
                                        Style="margin-left: 1px;" OnSelectedIndexChanged="ddlDocType_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                Select Paybasis:
                            </label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:UpdatePanel ID="atlasPaybasePNL" runat="server"        UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:DropDownList ID="dllPaybas" runat="server" CssClass="input" Style="margin-left: 1px;">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlDocType" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                        <td valign="top">
                            <font class="blackfnt">Select Date </font>
                        </td>
                        <td valign="top" align="left">
                            <Date:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center" colspan="4">
                            <label class="blackfnt">
                                <b>OR </b>
                            </label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                Enter Document No.(s):
                            </label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:TextBox ID="txtDockets" size="50" runat="server"></asp:TextBox>
                            <label class="blackfnt">
                                ( <i>Seperated by Comma if multiple. e.g 1122334,3344556,1564446 </i>)
                            </label>
                        </td>
                    </tr>
                </table>
                <br />
                <table border="0" align="center" class="boxbg" cellspacing="1" cellpadding="1" style="width: 8.5in">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="6" style="height: 30px;">
                            <label class="blackfnt">
                                <b>Document Forwarding Memo </b>
                            </label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                FM Number:
                            </label>
                        </td>
                        <td style="width: 15%" align="left" nowrap>
                            <label class="blackfnt" style="color: #FF0000">
                                &lt;System Generated&gt;
                            </label>
                        </td>
                        <td align="left" style="width: 14%" nowrap>
                            <label class="blackfnt">
                                FM Date:
                            </label>
                        </td>
                        <td align="left" style="width: 25%" nowrap>
                            <asp:TextBox ID="txtFMDate" MaxLength="10" size="10" runat="server" class="input"
                                onblur="isValidDate(this.value,'FM Date')"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtFMDate,'alnkFMDate','dd/MM/yyyy'); return false;"
                                id="alnkFMDate">
                                <img src="./../../images/calendar.jpg" border="0" />
                            </a>
                            <label class="blackfnt" style="vertical-align: text-top">
                                &nbsp;(dd/mm/yyyy)
                            </label>
                            <input type="hidden" id="HidSystemDate" runat="server" />
                        </td>
                        <td align="left" style="width: 14%" nowrap>
                            <label class="blackfnt">
                                FM Entry Date:
                            </label>
                        </td>
                        <td align="left">
                            <label class="blackfnt" style="vertical-align: middle" id="lblFMEntryDate" runat="server">
                            </label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%" nowrap>
                            <label class="blackfnt">
                                Manual FM Number:
                            </label>
                        </td>
                        <td style="width: 15%" align="left" colspan="5">
                            <asp:TextBox ID="txtManualFMNo" MaxLength="15" Width="120px" CssClass="input" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                Forward Document To:
                            </label>
                        </td>
                        <td align="left" style="width: 15%">
                            <asp:UpdatePanel ID="upCustLoc" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlFwdDocTo" runat="server" CssClass="input" OnSelectedIndexChanged="ddlFwdDocTo_SelectedIndexChanged"
                                        AutoPostBack="true">
                                        <asp:ListItem Value="" Selected="True" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Customer"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Location"></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlFwdDocTo" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        <td align="left" style="width: 14%" nowrap>
                            <label class="blackfnt">
                                Customer/Location:
                            </label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:UpdatePanel ID="upLocCust" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlCustomerLocation" runat="server" CssClass="input">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlFwdDocTo" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                Document Type:
                            </label>
                        </td>
                        <td style="width: 15%" align="left">
                            <label class="blackfnt" id="lblDocType" runat="server">
                            </label>
                        </td>
                        <td align="left" style="width: 14%" nowrap>
                            <label class="blackfnt">
                                Courier Name:
                            </label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:TextBox ID="txtCourier" runat="server" CssClass="input" MaxLength="100"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" style="width: 17%">
                            <label class="blackfnt">
                                Way Bill No.:
                            </label>
                        </td>
                        <td style="width: 15%" align="left">
                            <asp:TextBox ID="txtWayBillNo" runat="server" class="input" size="10" MaxLength="50"
                                onblur="JavaScript:this.value=this.value.toUpperCase()"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 14%" nowrap>
                            <label class="blackfnt">
                                Way Bill Date:
                            </label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:TextBox ID="txtWayBillDate" MaxLength="10" size="10" runat="server" class="input"
                                onblur="isValidDate(this.value,'Way BillDate')"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtWayBillDate,'alnkWayBillDate','dd/MM/yyyy'); return false;"
                                id="alnkWayBillDate">
                                <img src="./../../images/calendar.jpg" border="0" />
                            </a>
                            <label class="blackfnt" style="vertical-align: text-top">
                                &nbsp;(dd/mm/yyyy)
                            </label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" colspan="6">
                            <br style="font-size: 4pt;" />
                            <asp:UpdatePanel ID="upShowList"     UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="CmdAddRows" OnClientClick="JavaScript:return fsubmit12()" runat="server"
                                        OnClick="btnShowList_Click" Text="Show Documents >>" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                <br />
                <div class="blackfnt">
                    <asp:UpdatePanel ID="u1"    UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:GridView align="center" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2"
                                GridLines="None" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false"
                                PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                OnRowDataBound="GV_D_RowDataBound" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnPageIndexChanging="pgChange">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <center>
                                                <asp:CheckBox ID="chkOrderNo" runat="server" class="input" />
                                                <asp:HiddenField ID="hdncomm" Value='<% #DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                                    runat="server" />
                                            </center>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblSrNo" runat="server" Text="SR.NO."> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center>
                                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                    runat="server">
                                                </asp:Label>
                                                <asp:HiddenField ID="hidDocumentNo" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "DocumentNo")  %>' />
                                                <asp:HiddenField ID="hidDocumentDate" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "DocumentDate")  %>' />
                                            </center>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblorgdest" Text="Origin - Destination" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblorgdest_val" Text='<% #DataBinder.Eval(Container.DataItem, "loc")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblfrom_to" Text="From - To" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblfrom_to_val" Text='<% #DataBinder.Eval(Container.DataItem, "from_to")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldely_date" Text="Dely. Date" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldely_date_val" Text='<% #DataBinder.Eval(Container.DataItem, "dely_date")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldkttot" Text="Amt" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldkttot_val" Text='<% #DataBinder.Eval(Container.DataItem, "dkttot")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblScaned" Text="Scan Status" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblScaned_val" Text='<% #DataBinder.Eval(Container.DataItem, "Scaned")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-CssClass="balckfnt" HeaderText="" HeaderStyle-Width="15">
                                        <ItemTemplate>
                                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DocumentName") %>')">
                                                <font cssclass="Blackfnt">
                                                    <%#DataBinder.Eval(Container.DataItem, "View_st") %></a>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" CssClass="bgpink" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="white" Wrap="false" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" HorizontalAlign="Center" />
                                <PagerStyle HorizontalAlign="Center" BackColor="white" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <EmptyDataRowStyle Width="800px" BackColor="white" />
                            </asp:GridView>
                            <asp:GridView ID="dg_bill" runat="server" AutoGenerateColumns="False" CellSpacing="1"
                                GridLines="None" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" align="center" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" PagerSettings-FirstPageText="[First]"
                                PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkOrderNo" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sr No">
                                        <ItemTemplate>
                                            <center>
                                                <asp:Label ID="Lbl_Srno" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                            </center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill No">
                                        <ItemTemplate>
                                            <asp:Label ID="Lbl_Billno" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "billno")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manual Bill No">
                                        <ItemTemplate>
                                            <asp:Label ID="Lbl_Manualbillno" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "manualbillno")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Billdate" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "bgndt")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Billing Party">
                                        <ItemTemplate>
                                            <asp:Label ID="Lbl_Billingparty" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "ptmsnm")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="Lbl_Billamountno" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "billamt")  %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle BackColor="White" Wrap="false" HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Submission Location">
                                        <ItemTemplate>
                                            <asp:Label ID="Lbl_Submissionlocation" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "loc")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Scan Status">
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblScaned_val" Text='<% #DataBinder.Eval(Container.DataItem, "Scaned")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View">
                                        <ItemTemplate>
                                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DocumentName") %>')">
                                                <font cssclass="Blackfnt">
                                                    <%#DataBinder.Eval(Container.DataItem, "View_st") %>
                                                </font></a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="White" Wrap="false" />
                                <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" />
                                <PagerStyle HorizontalAlign="Center" BackColor="White" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <HeaderStyle CssClass="bgbluegrey" />
                                <EmptyDataRowStyle Width="800px" BackColor="white" />
                            </asp:GridView>
                            <asp:GridView align="center" ID="dg_coddod" runat="server" CellSpacing="1" CellPadding="2"
                                GridLines="None" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false"
                                PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                OnRowDataBound="GV_D_RowDataBound" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnPageIndexChanging="pgChange">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <center>
                                                <asp:CheckBox ID="chkOrderNo" runat="server" class="input" />
                                                <asp:HiddenField ID="hdncomm" Value='<% #DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                                    runat="server" />
                                            </center>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblSrNo" runat="server" Text="SR.NO."> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                runat="server">
                                            </asp:Label>
                                            <asp:HiddenField ID="hidDocumentNo" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "DocumentNo")  %>' />
                                            <asp:HiddenField ID="hidDocumentDate" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "DocumentDate")  %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document No">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblDocNo" runat="server" Text="Document No"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblDocumentno" Text='<% #DataBinder.Eval(Container.DataItem, "DocumentNo")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document Date">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblDocDt" runat="server" Text="Document No"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblDocumentDt" Text='<% #DataBinder.Eval(Container.DataItem, "DocumentDate")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblorgdest" Text="Origin - Destination" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblorgdest_val" Text='<% #DataBinder.Eval(Container.DataItem, "loc")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblfrom_to" Text="From - To" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblfrom_to_val" Text='<% #DataBinder.Eval(Container.DataItem, "from_to")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldely_date" Text="Dely. Date" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldely_date_val" Text='<% #DataBinder.Eval(Container.DataItem, "dely_date")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldkttot" Text="Amt" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lbldkttot_val" Text='<% #DataBinder.Eval(Container.DataItem, "dkttot")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblScaned" Text="Scan Status" runat="server"> </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblScaned_val" Text='<% #DataBinder.Eval(Container.DataItem, "Scaned")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-CssClass="balckfnt" HeaderText="" HeaderStyle-Width="15">
                                        <ItemTemplate>
                                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DocumentName") %>')">
                                                <font cssclass="Blackfnt">
                                                    <%#DataBinder.Eval(Container.DataItem, "View_st") %></a>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="true" CssClass="bgpink" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="white" Wrap="false" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" HorizontalAlign="Center" />
                                <PagerStyle HorizontalAlign="Center" BackColor="white" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <EmptyDataRowStyle Width="800px" BackColor="white" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <%--<asp:AsyncPostBackTrigger  ControlID="btnShowList" EventName="Click" />--%>
                            <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <br />
                <br />
                <div align="center" style="width: 10in">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Button ID="btnUpdt" OnClientClick="javascript:return fsubmit()" runat="server"
                                Text="Prepare New FM" OnClick="btnUpdt_Click" />
                            <asp:Label Visible="false" ID="lblerrro" runat="server"></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </td>
        </tr>
        <tr id="trSub" runat="server">
            <td align="center">
                <%--<asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="Button1"  runat="server" Text="Submit" OnClick="Button1_Click" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>--%>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
