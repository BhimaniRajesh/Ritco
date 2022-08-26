<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Payment_3.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="../VendorPayment.js"></script>

    <script language="javascript" type="text/javascript">
            var cal = new CalendarPopup("testdiv1"); 
	        cal.setCssPrefix("TEST");
	        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	        cal.showNavigationDropdowns();
	        User_CTR_Frm_Name="ctl00_MyCPH1_UCMyPaymentControl1_"
	        FRM_NM="ctl00_MyCPH1_"
	        var FinYear="<%=Session["FinYear"]%>"
		    var FinYear_to=parseInt(FinYear)+1
        		
	        if(FinYear_to<10)
	        {
	            FinYear_to="0"+FinYear_to
	        }
	        var FinYear_fromdate="01/04/"+FinYear
	        var FinYear_todate="31/03/"+FinYear_to
	        var Sle_finyear=FinYear+"-"+FinYear_to
        		
	        //onkeyup="javascript:Total_calC_THC_BalPayment()"	        
	        function Onclick_Calc()
	        {
	             Grid_Id="GV_BillList"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var TotalNetAmt=0
                 var Check_One="N"
                 for(var b=2;b<=rows;b++)
                 {
                       if(b<10)
                            GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                       else
                            GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                     
                        if(document.getElementById(GV_FRM_NM+"Chk_Docno").checked==true)
                        {
                            if(document.getElementById(GV_FRM_NM+"Txt_Pendamt").disabled==true)
                            {
                                document.getElementById(GV_FRM_NM+"Txt_Pendamt").disabled=false
                                document.getElementById(GV_FRM_NM+"Txt_Pendamt").value=document.getElementById(GV_FRM_NM+"Hnd_Pendamt").value
                            }
                            TotalNetAmt=parseFloat(TotalNetAmt)+parseFloat(document.getElementById(GV_FRM_NM+"Txt_Pendamt").value)
                        }
                        else
                        {
                            document.getElementById(GV_FRM_NM+"Txt_Pendamt").disabled=true
                            document.getElementById(GV_FRM_NM+"Txt_Pendamt").value='0.00'
                        }
                 } 
                 Set_Cash_Bank_Amt(TotalNetAmt)                                  
	        }
	        function OnBlurPendAmt_Calc()
	        {
	             Grid_Id="GV_BillList"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var TotalNetAmt=0
                 var Check_One="N"
                // alert("hi..")
                  for(var b=2;b<=rows;b++)
                  {
                           if(b<10)
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                           else
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                           document.getElementById(GV_FRM_NM+"Txt_Pendamt").value=rounditn(document.getElementById(GV_FRM_NM+"Txt_Pendamt").value,2)    
                           //  alert(parseFloat(document.getElementById(GV_FRM_NM+"Txt_Pendamt").value))
                            // alert(parseFloat(document.getElementById(GV_FRM_NM+"Hnd_Pendamt").value))
                           if(parseFloat(document.getElementById(GV_FRM_NM+"Txt_Pendamt").value) > parseFloat(document.getElementById(GV_FRM_NM+"Hnd_Pendamt").value))
                           {
                                alert("PLz Enter Payment Amount Less Then Or Equals to  Pending Amount")
                                document.getElementById(GV_FRM_NM+"Txt_Pendamt").focus();
                                return false;
                           }
                           TotalNetAmt=parseFloat(TotalNetAmt)+parseFloat(document.getElementById(GV_FRM_NM+"Txt_Pendamt").value)              
                                 
                    } 
                    Set_Cash_Bank_Amt(TotalNetAmt)
	        }
	        function   Set_Cash_Bank_Amt(TotalNetAmt)
	        {
                document.getElementById(User_Ctrl_FrmNm+"txtNetPay").value=rounditn(TotalNetAmt,2) 
                document.getElementById(User_Ctrl_FrmNm+"txtAmtApplA").value=rounditn(TotalNetAmt,2) 
                if(document.getElementById(User_Ctrl_FrmNm+"ddlPayMode").value=="Cash")
                {
                    document.getElementById(User_Ctrl_FrmNm+"txtCashAmt").value=rounditn(TotalNetAmt,2) 
                }
                else if(document.getElementById(User_Ctrl_FrmNm+"ddlPayMode").value=="Bank")
                {
                    document.getElementById(User_Ctrl_FrmNm+"txtChqAmt").value=rounditn(TotalNetAmt,2) 
                }
	        }
    </script>
    <div align="left" style="width: 9.5in;">
        <asp:UpdatePanel ID="UpdatePanePayment"  UpdateMode="Conditional" RenderMode="Inline"
            runat="server">
            <ContentTemplate>
                <br />
                <table width="1000" border="0" cellspacing="0" cellpadding="0" align="left">
                    <tr>
                        <td>
                            <table border="0" cellpadding="3" width="800" cellspacing="1" align="left" class="boxbg">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <font class="blackfnt"><b>
                                            <asp:Label Font-Bold="true" ID="Trn_Title1" runat="server" CssClass="blackfnt" Text="Selected Criteria"></asp:Label>
                                        </b></font>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td>
                                        <label class="blackfnt">
                                            Date Selected :</label>
                                    </td>
                                    <td>
                                        &nbsp;<asp:Label ID="Lbl_Date" runat="server" CssClass="blackfnt" Text="-"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #FFFFFF">
                                    <td style="width: 205">
                                        <label class="blackfnt">
                                            Vendor Name & Code:</label></td>
                                    <td>
                                        &nbsp;<asp:Label ID="Lbl_Vendor" Text="-" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #FFFFFF" id="TR_Billno" runat="server" visible="false">
                                    <td>
                                        <label class="blackfnt">
                                            Billno Entry No. :</label></td>
                                    <td>
                                        &nbsp;<asp:Label ID="Lbl_Billno" runat="server" CssClass="blackfnt" Text="-"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #FFFFFF" id="TR_VBillno" runat="server" visible="false">
                                    <td>
                                        <label class="blackfnt">
                                            Vendor Billno No. :</label></td>
                                    <td>
                                        &nbsp;<asp:Label ID="Lbl_VBillno" runat="server" CssClass="blackfnt" Text="-"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <table border="0" cellpadding="3" width="800" cellspacing="1" align="left" class="boxbg">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <font class="blackfnt"><b>
                                            <asp:Label Font-Bold="true" ID="Label1" runat="server" CssClass="blackfnt" Text="BillEntry Payment Details"></asp:Label>
                                        </b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="Left">
                                        <font class="blackfnt">Voucher Date</font>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">
                                            <asp:TextBox ID="TxtVoucherDT" runat="server" Width="65px" Columns="10" 
                                                BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtVoucherDT,'a1','dd/MM/yyyy'); return false;"
                                                name="a1" id="a1">
                                                <img src="../../../images/calendar.jpg" border="0" />
                                            </a>DD/MM/YYYY </font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">Manual Voucher No</font></td>
                                    <td align="left">
                                        <font class="bluefnt">
                                            <asp:TextBox ID="Txt_Manual_Voucherno" runat="server" Width="100px" onblur="javascript:this.value=this.value.toUpperCase()"
                                                BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                            <asp:HiddenField ID="Hnd_Server_dt" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <br />
                            <asp:GridView ID="GV_BillList" runat="server" align="left" BorderWidth="0" CellSpacing="1"
                                CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                                Width="80%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                <PagerStyle VerticalAlign="Bottom" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" />
                                         
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblBillno" Text='<%# DataBinder.Eval(Container.DataItem, "Billno") %>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill Date" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LBLBilldt" Text='<%# DataBinder.Eval(Container.DataItem, "Billdt") %>'
                                                runat="server">
                                            </asp:Label>
                                            <asp:HiddenField ID="hnd_Billdate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Billdate") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor Bill No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblVBillno" Text='<%# DataBinder.Eval(Container.DataItem, "VBillno") %>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor Code & Name" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblVendor" Text='<%# DataBinder.Eval(Container.DataItem, "vendorcd") %>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Paid Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblPaidamt" Text='<%# DataBinder.Eval(Container.DataItem, "Paidamt") %>'
                                                runat="server">
                                                
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pending  Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:HiddenField ID="Hnd_Pendamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>' />
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Txt_Pendamt" onblur="javascript:OnBlurPendAmt_Calc()"
                                                Font-Bold="true" runat="server" Enabled="true" MaxLength="12" Text='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>'
                                                Columns="10"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total  Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblTotal" Text='<%# DataBinder.Eval(Container.DataItem, "Totalamt") %>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                        <FooterTemplate>
                                            <asp:Label ID="Lbltotal" Font-Bold="true" runat="server" Text="Total Amount" CssClass="blackfnt"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr id="Payment_Row4" runat="server">
                        <td align="left">
                            <asp:UpdateProgress ID="uppMain" runat="server">
                                <ProgressTemplate>
                                    <iframe frameborder="1" src="about:blank" style="border: 0px; position: absolute;
                                        z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                                        height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
                                    </iframe>
                                    <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                                        top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                                        <table style="border: solid #8ba0e5 2px; z-index: 98; width: 200px;
                                            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                            <tr>
                                                <td align="right">
                                                    <img src="../../../images/loading.gif" alt="" /></td>
                                                <td>
                                                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                                            </tr>
                                        </table>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <asp:HiddenField ID="Hnd_Doc_type" runat="server" />
                        </td>
                    </tr>
                    <tr id="Payment_Row3" runat="server">
                        <td>
                            <br />
                            <table border="0" cellspacing="1" cellpadding="4" width="800" align="left" class="boxbg">
                                <caption>
                                    <font class="blackfnt">Note : Please enter the payment details if Net Payable amount &gt;0 . </font>
                                    <tr class="bgbluegrey">
                                        <td align="center" colspan="4"><font class="blackfnt"><b>Payment Details</b></font> </td>
                                    </tr>
                                    <tr style="background-color: #FFFFFF">
                                        <td align="center" colspan="4">
                                            <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server" />
                                        </td>
                                    </tr>
                                </caption>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <table align="left" cellspacing="1" width="80%" class="boxbg" border="0" id="ON_Submit"
                                runat="server">
                                <tr class="bgbluegrey">
                                    <td colspan="4" align="center" style="height: 21px">
                                        <asp:Button ID="btn_submit" Text="Submit" OnClick="btn_submit_Click" BorderStyle="Groove"
                                            CssClass="blackfnt" OnClientClick="javascript:return OnSubmit_BillEntryPayment()"
                                            runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <script type="text/javascript" language="javascript">
        window.onload=OnBlurPendAmt_Calc
        </script>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
