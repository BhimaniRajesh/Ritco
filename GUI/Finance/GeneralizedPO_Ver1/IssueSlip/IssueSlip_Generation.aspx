<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="IssueSlip_Generation.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_GRNCriteria" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage"
    TagPrefix="uc1" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        frm_name="ctl00$MyCPH1$"
        User_CTR_Frm_Name="ctl00$MyCPH1$UCMyPaymentControl1$"
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		if(FinYear_to<10)
		{
    		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
        function OnSubmitStep1() {

            FRM_Name = "ctl00_MyCPH1_"
            var Issue_Date = document.getElementById(FRM_Name + "txtIssueDate").value
            var TxtDocNo = document.getElementById(FRM_Name + "TxtDocNo").value
            var TxtReqNo = document.getElementById(FRM_Name + "TxtReqNo").value
            var TxtReqDate = document.getElementById(FRM_Name + "TxtReqDate").value
            ddlMatCat = document.getElementById("ctl00_MyCPH1_DDLMatCat");
            if (ddlMatCat.value == "") {
                alert("Please Select Material Category For Issue Slip Generation");
                document.getElementById("ctl00_MyCPH1_ddlMatCat").focus()
                return false;
            }
            if (ddlMatCat.value == "01") 
            {
                if (TxtDocNo == "") {
                    alert("Please Enter CFR MR Number");
                    document.getElementById(FRM_Name + "TxtDocNo").focus()
                    return false;
                }
            }
            if (ddlMatCat.value == "03") 
            {
                if (TxtDocNo == "") {
                    alert("Please Enter Job Sheet Number");
                    document.getElementById(FRM_Name + "TxtDocNo").focus()
                    return false;
                }
            }
            if (Issue_Date == "") {
                alert("Please Enter Issue Slip Date");
                document.getElementById(FRM_Name + "txtIssueDate").focus()
                return false;
            }            
            if (TxtReqNo == "") {
                alert("Please Enter Requisition Number");
                document.getElementById(FRM_Name + "TxtReqNo").focus()
                return false;
            }
            if (TxtReqDate == "") {
                alert("Please Enter Requisition Date");
                document.getElementById(FRM_Name + "TxtReqDate").focus()
                return false;
            }
            if (ddlMatCat.value == "02" || ddlMatCat.value == "03") 
            {
                if(document.getElementById(FRM_Name + "TxtVehicle").value=="")
                {
                    alert("Please Enter Vehicle Number");
                    document.getElementById(FRM_Name + "TxtVehicle").focus()
                    return false;
                }
            }
        }
        function Show_assetNM(Obj, Type) {
            //debugger;
            FRM_Name = "ctl00$MyCPH1$"
            Total_Grid_ROW = document.getElementById(FRM_Name + "txtRows").value
            if (Total_Grid_ROW == "") 
            {
                Total_Grid_ROW = "5"
            }
            
            if (Obj.value == "") 
            {
                return false;
            }
            var len = Obj.length;
            var pref = Obj.substring(0,len-9);
            
            var TxtAssetcode = Obj;            
            var txtastnm = TxtAssetcode.replace("txtassetcd", "txtastnm");
            var Assetcode_Arr = document.getElementById(TxtAssetcode).value.split("~");
            Assetcode = Assetcode_Arr[1]
            if (document.getElementById(TxtAssetcode).value == "") 
            {
                return false;
            }
            if (Assetcode != "") 
            {
                var findobj = false;
                findobj = GetXMLHttpObject();
                if (findobj) 
                {
                    var strpg = "CheckExist.aspx?mode=" + Type + "&Code=" + Assetcode + "&sid=" + Math.random();
                    findobj.open("GET", strpg, true);
                    findobj.onreadystatechange = function() 
                    {
                        if (findobj.readyState == 4 && findobj.status == 200) 
                        {
                            var res = findobj.responseText.split("|");

                            if (res[0] == "false") 
                            {
                                alert("Item Code is not Valid... Please Enter Valid Item Code");
                                document.getElementById(TxtAssetcode).value = "";
                                document.getElementById(TxtAssetcode).focus();
                                return false;
                            }
                            else if(res[0]=="true")
                            {
                                var Assetcd
                                for (var i = 0; i < Total_Grid_ROW; i++) {
                                    j = i + 2
                                    if (j < 10) {
                                        GV_Frm_Name = "ctl00_MyCPH1_GV_Details_ctl0" + j + "_";
                                    }
                                    else {
                                        GV_Frm_Name = "ctl00_MyCPH1_GV_Details_ctl" + j + "_";
                                    }
                                    Assetcd = document.getElementById(GV_Frm_Name + "txtMaterial").value
                                    if (Assetcd != "") 
                                    {
                                        document.getElementById(GV_Frm_Name + "txtqty").innerText=res[1];
                                        //return true;
                                    }
                                }
                            }
                        }
                    }
                    findobj.send(null);
                }
                return false;
            }
        }
        function Check_Calc() {
            FRM_Name = "ctl00$MyCPH1$"
            Total_Grid_ROW = document.getElementById(FRM_Name + "txtRows").value
            if (Total_Grid_ROW == "") {
                Total_Grid_ROW = "5"
            }
            var Qty, txtIssuedQTY;
            var Assetcd
            for (var i = 0; i < Total_Grid_ROW; i++) {
                j = i + 2
                if (j < 10) {
                    GV_Frm_Name = "ctl00_MyCPH1_GV_Details_ctl0" + j + "_";
                }
                else {
                    GV_Frm_Name = "ctl00_MyCPH1_GV_Details_ctl" + j + "_";
                }
                Qty = document.getElementById(GV_Frm_Name + "txtqty").innerText
                txtRequiredQTY = document.getElementById(GV_Frm_Name + "txtRequiredQTY").value
                Assetcd = document.getElementById(GV_Frm_Name + "txtMaterial").value
                if (Assetcd != "") 
                {
                    if (parseFloat(Qty) <= parseFloat(txtRequiredQTY)) 
                    {
                        document.getElementById(GV_Frm_Name + "txtIssuedQTY").innerText = parseFloat(Qty);
                    }
                    else
                    {
                        document.getElementById(GV_Frm_Name + "txtIssuedQTY").innerText = parseFloat(txtRequiredQTY);
                    }
                }
            }
        }
        function OnSubmit() {
            FRM_Name = "ctl00_MyCPH1_"
            var Issue_Date = document.getElementById(FRM_Name + "txtIssueDate").value
            if (Issue_Date == "") {
                alert("Please Enter Issue Slip Date");
                document.getElementById(FRM_Name + "txtIssueDate").focus()
                return false;
            }
            
            var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
            var dt =Issue_Date
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
		
            if (dt > FinYear_todate1 || dt < FinYear_fromdate1) {
                alert("You have Selected Finacial Year as " + Sle_finyear + " , SO Issue Slip Date Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!")
                document.getElementById(FRM_Name + "txtIssueDate").focus();
                return false;
            }
            if (dt > server_dt) {
                alert("Issue Slip Date should not be greater than today's date !!!")
                document.getElementById(FRM_Name + "txtIssueDate").focus();
                return false;
            }
            FRM_Name="ctl00$MyCPH1$"
            Slect_One_YN="N"
            var grid=document.getElementById("ctl00_MyCPH1_GV_Details");
            var rows=grid.rows.length;  
            for(var i=2;i<rows-1;i++)
            {                
                j=i
                if(j<10)
                {
                    GV_Frm_Name="ctl00_MyCPH1_GV_Details_ctl0"+j+"_";
                }
                else
                {
                    GV_Frm_Name="ctl00_MyCPH1_GV_Details_ctl"+j+"_"; 
                }
                Assetcd=document.getElementById(GV_Frm_Name+"txtMaterial").value
                if(Assetcd!="")
                {
                    Slect_One_YN="Y"
                }
            }		     
            if(Slect_One_YN=="N")
            {
                alert( "PLz Enter Atleast One Record For Issue Slip. !!!")
                return false;
            }
        }
        function validPODate(id)
        {
            var txtdate=document.getElementById(id);
    
            if(!isValidDate(txtdate.value,"Date"))
                return false;
        }
        
        function DocBlur(id)
        {
            ddlMatCat = document.getElementById("ctl00_MyCPH1_DDLMatCat");
            var str="";
            for(var i=0;i<id.length-12;i++)
            {
                str+=id.charAt(i);
            }
            var txtMRno=document.getElementById(id);
               
            var MRNo=txtMRno.value;
            if(MRNo=="")
            {
                return false;
            }
           
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
             var strpg="BringVoucherDetails.aspx?mode=" + ddlMatCat.value + "&code=" + MRNo + "&sid=" + Math.random();
             findobj.open("GET",strpg,true);
             findobj.onreadystatechange=function()
                 {
                     if(findobj.readyState==4 && findobj.status==200)
                        {
                            //debugger;
                            var res=findobj.responseText.split("|");
                            if(res[0]=="false")
                                {
                                    alert(res[1]);
                                    txtMRno.value="";
                                    txtMRno.focus();
                                    return false;
                                }
                        }
                 }
                 
            findobj.send(null);
            }
            return false;
        }
    </script>
    <asp:UpdatePanel ID="up1" RenderMode="Inline" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <div>
                <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 90%;"
                                align="left">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="6">
                                        <strong><span style="font-size: 8pt; font-family: Verdana">Issue Slip Generation Information</span></strong>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff" id="trMatCat" runat="server">
                                    <td>
                                        <label class="blackfnt">
                                            Select Material Category :
                                        </label>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="DDLMatCat" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMatCat_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <label class="blackfnt">
                                            <asp:Label ID="LblNumber" Text="Document Number :" runat="server" ForeColor="Black"
                                                CssClass="blackfnt"></asp:Label>
                                        </label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtDocNo" runat="server" MaxLength="100" Width="150px" BorderStyle="Groove"
                                            CssClass="EntryText"></asp:TextBox>
                                    </td>
                                    <td>
                                        <label class="blackfnt">
                                            Vehicle No :
                                        </label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TxtVehicle" runat="server" MaxLength="100" Width="100px" BorderStyle="Groove"></asp:TextBox>
                                        <ajaxToolkit:AutoCompleteExtender ID="Ext111" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                            ServiceMethod="GetVehicleMaster" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="TxtVehicle">
                                        </ajaxToolkit:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td>
                                        <label class="blackfnt">
                                            Issue Slip Number :
                                        </label>
                                    </td>
                                    <td>
                                        <asp:Label ID="l1" Text="< System Generated... >" runat="server" ForeColor="red"
                                            CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td>
                                        <label class="blackfnt">
                                            Issue Date :</label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIssueDate" Width="70" runat="server" CssClass="blackfnt" onblur="javascript:return validPODate(this.getAttribute('id'));"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtIssueDate,'anchor2','dd/MM/yyyy'); return false;"
                                            name="anchor2" id="anchor2">
                                            <img src="./../../../images/calendar.jpg" border="0" alt="" />
                                        </a><font class="blackfnt">dd/mm/yyyy</font>
                                    </td>
                                    <td align="left">
                                        <label class="blackfnt">
                                            Issue Location :</label>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblIssueLoc" runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <label class="blackfnt">
                                            Requisition Number :</label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TxtReqNo" runat="server" MaxLength="100" Width="150px" BorderStyle="Groove"
                                            CssClass="EntryText"></asp:TextBox>
                                    </td>
                                    <td>
                                        <label class="blackfnt">
                                            Requisition Date :</label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtReqDate" Width="70" runat="server" CssClass="blackfnt" onblur="javascript:return validPODate(this.getAttribute('id'));"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtReqDate,'anchor1','dd/MM/yyyy'); return false;"
                                            name="anchor1" id="anchor1">
                                            <img src="./../../../images/calendar.jpg" border="0" alt="" />
                                        </a><font class="blackfnt">dd/mm/yyyy</font>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <label class="blackfnt">
                                            Comments :</label>
                                    </td>
                                    <td align="left" colspan="5">
                                        <asp:TextBox ID="TxtComments" runat="server" Width="500px" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey" id="trStep1" runat="server">
                                    <td colspan="6" align="right" style="height: 21px">
                                        <asp:Button ID="btnStep1" runat="server" Text="Step - 1" Font-Bold="true" OnClientClick="javascript:return OnSubmitStep1();"
                                            OnClick="btnStep1_Click" />
                                    </td>
                                </tr>
                                <caption>
                                    <br />
                                    <tr id="trIndexRow" runat="server" bgcolor="white">
                                        <td align="center" colspan="6">
                                            <br />
                                            <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="350">
                                                <tr style="background-color: White">
                                                    <td class="blackfnt" style="text-align: left">
                                                        &nbsp;Enter No. of Rows
                                                    </td>
                                                    <td class="blackfnt" style="text-align: left">
                                                        &nbsp;<asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" 
                                                            CssClass="blackfnt" Width="100px"></asp:TextBox>
                                                        &nbsp;<asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Submit" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr id="trGrid" runat="server" style="background-color: #FFFFFF; display: none">
                                        <td align="left" colspan="6" style="height: 21px">
                                            <asp:GridView ID="GV_Details" runat="server" align="left" 
                                                AutoGenerateColumns="False" BackColor="white" CssClass="boxbg" 
                                                FooterStyle-CssClass="blackfnt" HeaderStyle-CssClass="bgbluegrey" 
                                                OnRowDataBound="GV_D_OnRowDataBound" PagerStyle-HorizontalAlign="left" 
                                                SelectedIndex="1" ShowFooter="True" Width="100">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                                        <ItemStyle CssClass="blackfnt" Font-Bold="true" Wrap="false" />
                                                        <HeaderTemplate>
                                                            <center>
                                                                <asp:Label ID="lblItemHeader" runat="server" Width="150px"></asp:Label>
                                                            </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtMaterial" runat="server" BorderStyle="Groove" 
                                                                onblur="javascript:return Show_assetNM(this.getAttribute('id'),'SKU');" 
                                                                Width="200px"></asp:TextBox>
                                                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" 
                                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" 
                                                                CompletionListItemCssClass="autocomplete_listItem" Enabled="True" 
                                                                MinimumPrefixLength="1" ServiceMethod="Get_MaterialDetails" 
                                                                ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtMaterial">
                                                            </ajaxToolkit:AutoCompleteExtender>
                                                            <asp:TextBox ID="txtFixAsset" runat="server" BorderStyle="Groove" 
                                                                onblur="javascript:return Show_assetNM(this.getAttribute('id'),'SKU');" 
                                                                Width="200px"></asp:TextBox>
                                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" 
                                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" 
                                                                CompletionListItemCssClass="autocomplete_listItem" Enabled="True" 
                                                                MinimumPrefixLength="1" ServiceMethod="Get_FixAsset" 
                                                                ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtFixAsset">
                                                            </ajaxToolkit:AutoCompleteExtender>
                                                            <br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Description">
                                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center" 
                                                            Wrap="True" />
                                                        <ItemStyle CssClass="blackfnt" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtdesc" runat="server" BorderStyle="Groove" 
                                                                CssClass="blackfnt" TextMode="MultiLine" Width="300"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="QTY In Stock">
                                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center" 
                                                            Wrap="True" />
                                                        <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Center"/>
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtqty" runat="server" BorderStyle="Groove" 
                                                                CssClass="blackfnt" Width="100" Enabled="false"></asp:TextBox>
                                                            <%--<asp:Label ID="txtqty" runat="server" CssClass="blackfnt" Width="100"></asp:Label>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Required QTY">
                                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center" 
                                                            Wrap="True" />
                                                        <ItemStyle CssClass="blackfnt" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtRequiredQTY" runat="server" BorderStyle="Groove" 
                                                                CssClass="blackfnt" MaxLength="8" onblur="javascript:return Check_Calc()" 
                                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" 
                                                                Text="0.00" Width="100"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Issued QTY">
                                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center" 
                                                            Wrap="True" />
                                                        <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Center"/>
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtIssuedQTY" runat="server" BorderStyle="Groove" 
                                                                CssClass="blackfnt" Width="100" Enabled="false"></asp:TextBox>
                                                            <%--<asp:Label ID="txtIssuedQTY" runat="server" CssClass="blackfnt" Width="100"></asp:Label>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="trFinalSubmit" runat="server" style="background-color: #FFFFFF">
                                        <td align="center" colspan="6" style="height: 21px">
                                            <table id="ON_Submit" runat="server" align="center" border="0" cellspacing="1" 
                                                class="boxbg" style="width: 100%">
                                                <tr class="bgbluegrey">
                                                    <td align="center" colspan="4" style="height: 21px">
                                                        <asp:Button ID="btn_submit" runat="server" CssClass="blackfnt" 
                                                            OnClick="btn_submit_Click" OnClientClick="javascript:return OnSubmit()" 
                                                            Text="Submit" />
                                                        <uc1:UserMessage ID="MsgBox" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </caption>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="HidIssueDate" runat="server" />
                <asp:HiddenField ID="HidMatCat" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
