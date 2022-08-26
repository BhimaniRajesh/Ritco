<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Advance_Advance_Step2.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" src="./../../../images/dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript" src="../../Finance/VendorPayment_Ver1/VendorPayment.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">

    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	cal.showNavigationDropdowns();
	User_CTR_Frm_Name="ctl00_MyCPH1_UCMyPaymentControl1_"
	User_Ctrl_FrmNm="ctl00_MyCPH1_UCMyPaymentControl1_"
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
		
	
	 
	function THC_ADVPayment_OnSubmit(GRID_ID)
	{
	       //alert(GRID_ID)
	      // return false;
	            var server_dt=document.getElementById(FRM_NM+"Hnd_ServerDt").value
                var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
			   
                 var grid=document.getElementById("ctl00_MyCPH1_"+GRID_ID);
                // alert(grid)
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                  var i=0    
                  if (dt=="")
				  {
						                alert( "Payment Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				  }
                  for(var b=2;b<=rows-1;b++)
                  {
                           // alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                                hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_Hnd_Docdt" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                                 hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_Hnd_Docdt";
                            }
                           // alert(hdndockdt)
                            hdndockdt = document.getElementById(hdndockdt).value;     
                             //alert("----1"+hdndockdt)      
                            //if(document.getElementById(GV_FRM_NM+"chksrno").checked)
                            //{
                                 Check_One="Y"
                                 i=i+1 
                                 var Maxdt1 =Maxdt
                				
				                 var Maxdt_dd=Maxdt1.substring(0,2)
				                 var Maxdt_mm=Maxdt1.substring(3,5)
				                 var Maxdt_yy=Maxdt1.substring(6,10)
                                    
		                         var hdndockdt1 =hdndockdt
				                 var hdndockdt_dd=hdndockdt1.substring(0,2)
				                 var hdndockdt_mm=hdndockdt1.substring(3,5)
				                 var hdndockdt_yy=hdndockdt1.substring(6,10)
            				   // alert(b+"-"+hdndockdt1+"-"+hdndockdt_dd+"-"+hdndockdt_mm+"-"+hdndockdt_yy+"-"+hdndockdt+"-"+months[parseFloat(hdndockdt_mm)])
            				   // alert(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
				                 Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                         hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                    //alert(Maxdt1)
				                    // alert("docdt:-"+hdndockdt1)
			                        // alert("Max dt-1:-"+Maxdt1)
                                if (hdndockdt1>Maxdt1)
                                {
                                Maxdt1=hdndockdt1
                                Maxdt=hdndockdt
                                }
                               // alert("Max dt-2:-"+Maxdt1)
                                //alert("Max dt-3:-"+Maxdt)
                           // }
                     }
                                
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
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Payment Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						return false;
				}
				
                 Fromdate1=Maxdt1
			     Fromdate=Maxdt
			     
                              if (dt<Fromdate1)
				                {
						                alert( "Payment Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Payment Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
 
				        // alert("hi...1")   
				         
			if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="-1")
            {
                                       alert( "Plz Select Mode of Transacction !!!")
						              document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						              return false;
            }	
            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both" && i>1)
            {
                                      alert( "You have Selected Multiple Records For Both Payment,You have to select Single Records For Both Paymtn!!!")
						              document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						              return false;
            }	                		                
            
		 if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Cash")
         {
            if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
             {                         
                                      alert( "Cash Amount Must Be Greater Than Zero !!!")
						             // document.getElementById(FRM_Name+"txtreqdt").focus();
						              return false;
             }
             if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
             {                         
                                      alert( "PLz Select Cash Account !!!")
						              document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						              return false;
             }
             
        }
        else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Bank")
        {
            if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
             {  
                         alert( "Cheque Amount Must Be Greater Than Zero !!!")
						// document.getElementById(FRM_Name+"txtreqdt").focus();
						 return false;
			}
			if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
             {                         
                                      alert( "PLz Select BANK Account !!!")
						              document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						              return false;
             }
             if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
             {                         
                                      alert( "PLz Enter Cheque No!!!")
						              document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						              return false;
             }
             if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
             {                         
                                      alert( "PLz Enter Cheque Date !!!")
						              document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						              return false;
             }
             
        }
         else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both")
         {
            if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
             {                         
                                      alert( "Cash Amount Must Be Greater Than Zero !!!")
						             document.getElementById(User_CTR_Frm_Name+"txtCashAmt").focus();
						              return false;
             }
              if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
             {                         
                                      alert( "PLz Select Cash Account !!!")
						              document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						              return false;
             }
             if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
             {  
                         alert( "Cheque Amount Must Be Greater Than Zero !!!")
						 document.getElementById(User_CTR_Frm_Name+"txtChqAmt").focus();
						 return false;
			}
			if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
             {                         
                                      alert( "PLz Select BANK Account !!!")
						              document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						              return false;
             }
             if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
             {                         
                                      alert( "PLz Enter Cheque No!!!")
						              document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						              return false;
             }
             if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
             {                         
                                      alert( "PLz Enter Cheque Date !!!")
						              document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						              return false;
             }
              
        }	 
        for(var b=2;b<=rows-1;b++)
        {
                           // alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                            }
                            document.getElementById(GV_FRM_NM+"Ind_BalAmt").disabled=false	
        }
        //alert("Done")
        //return false; 
        if(!confirm("Are You Sure That All Payment Details Are Correct Or Not"))
        return false; 
       	document.getElementById(User_CTR_Frm_Name+"txtChqDate").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqNo").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtNetPay").disabled=false
		document.getElementById(User_CTR_Frm_Name+"txtCashAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").disabled=false	
		//alert("Done")
}


    </script>

    <br />
    <div align="left">
        <table>
            <tr>
                <td>
                    <table border="0" style="width: 8in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                        class="boxbg">
                        <asp:HiddenField ID="click_count" runat="server" Value="0" />
                        <asp:HiddenField ID="Hnd_ServerDt" runat="server" Value="0" />
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font face="verdana" size="3"><b>
                                    <asp:Label ID="Lbl_Title" runat="server" Font-Bold="true" CssClass="blackfnt" Text="DDMR Vendor Payment"></asp:Label>
                                </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td align="Left">
                                <font class="blackfnt">Voucher Date </font>
                            </td>
                            <td align="left">
                                <font class="bluefnt">
                                    <asp:TextBox ID="TxtVoucherDT" runat="server" Width="65px" Columns="10" onblur="javascript:MIn_Max_Date_Validation(this,'date')"
                                        BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtVoucherDT,'anchor1','dd/MM/yyyy'); return false;"
                                        name="anchor1" id="a1">
                                        <img src="../../images/calendar.jpg" border="0" />
                                    </a>dd/mm/yyyy </font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">Manual Voucher No.</font>
                            </td>
                            <td align="left">
                                <font class="bluefnt">
                                    <asp:TextBox ID="Txt_Manual_Voucherno" runat="server" Width="100px" 
                                        BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td align="Left">
                                <font class="blackfnt">Advance Entry Location </font>
                            </td>
                            <td>
                                <asp:TextBox ID="Txt_Next_Loc" runat="server" Text='' Width="200" CssClass="blackfnt"
                                    BorderStyle="Groove" Enabled="false"></asp:TextBox>
                                <div id="Abc" runat="server" class="boxbg" />
                                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                    ServiceMethod="GetLocation" ServicePath="AtlasAutoComplete.asmx" TargetControlID="Txt_Next_Loc">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="TR_THC_ADV" runat="server" visible="false">
                <td>
                    <br />
                    <div align="left">
                        <asp:GridView ID="GV_THC_ADV_PAYMENT" align="center" runat="server" AutoGenerateColumns="False"
                            Width="800px" BorderWidth="0" CellSpacing="1" CellPadding="2" BorderStyle="None"
                            CssClass="boxbg" Visible="true" ShowFooter="true" EmptyDataText="No Records Found..."
                            Style="width: 8in">
                            <%--OnRowDataBound="CustomersGridView_RowDataBound"  --%>
                            <Columns>
                                <asp:TemplateField HeaderText="SRNo." ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <a href="#" id="<%# Container.DataItemIndex+1 %>contentlink2" rel="<%# Container.DataItemIndex+1 %>subcontent2">
                                            <asp:Label ID="docno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"DDMRNo") %>'></asp:Label>
                                        </a>
                                        <asp:HiddenField ID="Hnd_Docdt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"DDMRDt") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Contract Amt.(+)"
                                            runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="indpcamt"
                                            runat="server" Enabled="false" MaxLength="12" Columns="10" Text='<%# DataBinder.Eval(Container.DataItem,"ContAmt") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblAdvamt" Style="text-align: center" CssClass="blackfnt" Text="Advance Amt. (-) "
                                            runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="indadvamt"
                                            MaxLength="12" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:Total_calC_THC_ADVPayment()" Columns="10" 
                                            runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AdvAmt") %>' Enabled="false"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="TotalNetamt"
                                            Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10" ></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblBalAmt" Style="text-align: center" CssClass="blackfnt" Text="Net Balance"
                                            runat="server" ></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Ind_BalAmt"
                                            MaxLength="10" Columns="8" Enabled="false" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BalAmt") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle />
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="bgbluegrey" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <iframe frameborder="1" src="about:blank" style="border: 0px; position: absolute;
                                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
                            </iframe>
                            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img src="../../images/loading.gif" alt="" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <br />
                    <table border="0" cellspacing="1" cellpadding="4" width="700" align="left" class="boxbg">
                        <font class="blackfnt">Note : Please enter the payment details if Advance Amount>0 . </font>
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center">
                                <font class="blackfnt"><b>Payment Details</font>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td colspan="4" align="center">
                                <asp:UpdatePanel ID="UpdatePanePayment" runat="server">
                                    <ContentTemplate>
                                        <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server"></UC5:UCMyPaymentControl>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <%--<asp:HiddenField ID="Hnd_Doc_type" runat="server" />--%>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>

        <script language="javascript" type="text/javascript">

            window.onload = onPageLoad
            function onPageLoad() {
                var grid = document.getElementById("ctl00_MyCPH1_GV_THC_ADV_PAYMENT");
                var rows = grid.rows.length;
                var Total_AdvAmt = 0

                for (var b = 2; b < rows; b++) {
                    if (b < 10) {
                        GV_FRM_NM = "ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl0" + b + "_";
                    }
                    else {
                        GV_FRM_NM = "ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl" + b + "_";
                    }
                    IndPCAmt = document.getElementById(GV_FRM_NM + "indpcamt").value
                    //IndOthAmt = document.getElementById(GV_FRM_NM + "indothamt").value
                    //IndTds=document.getElementById(GV_FRM_NM+"Ind_Tds").value     
                    //IndStax=document.getElementById(GV_FRM_NM+"Ind_Stax").value         
                    IndAdvAmt = document.getElementById(GV_FRM_NM + "indadvamt").value
                    Ind_BalAmt = document.getElementById(GV_FRM_NM + "Ind_BalAmt").value
                    var NetBalAmt = 0
                    IndOthAmt =0
                    if (parseFloat(IndPCAmt) > 0) {
                        NetBalAmt = parseFloat(IndPCAmt) + parseFloat(IndOthAmt) - parseFloat(IndAdvAmt)
                        if (parseFloat(NetBalAmt) < 0) {
                            WO_AdvAmt = parseFloat(IndPCAmt) + parseFloat(IndOthAmt)
                            alert("Advance Amount Should Be Less Then Contract Amt + Other Amt. - Tds + S.Tax : " + WO_AdvAmt)
                            document.getElementById(GV_FRM_NM + "indadvamt").focus()
                            return false;
                        }
                        else {
                            document.getElementById(GV_FRM_NM + "Ind_BalAmt").value = rounditn(NetBalAmt, 2)
                        }
                    }
                    Total_AdvAmt = parseFloat(Total_AdvAmt) + parseFloat(document.getElementById(GV_FRM_NM + "indadvamt").value)
                }
                if (rows < 10) {
                    GV_FRM_NM = "ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl0" + rows + "_";
                }
                else {
                    GV_FRM_NM = "ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl" + rows + "_";
                }
                document.getElementById(GV_FRM_NM + "TotalNetamt").value = rounditn(Total_AdvAmt, 2)
                document.getElementById(User_Ctrl_FrmNm + "txtNetPay").value = rounditn(Total_AdvAmt, 2)
                document.getElementById(User_Ctrl_FrmNm + "txtAmtApplA").value = rounditn(Total_AdvAmt, 2)
                if (document.getElementById(User_Ctrl_FrmNm + "ddlPayMode").value == "Cash") {
                    document.getElementById(User_Ctrl_FrmNm + "txtCashAmt").value = rounditn(Total_AdvAmt, 2)
                }
                else if (document.getElementById(User_Ctrl_FrmNm + "ddlPayMode").value == "Bank") {
                    document.getElementById(User_Ctrl_FrmNm + "txtChqAmt").value = rounditn(Total_AdvAmt, 2)
                }
            }          
        </script>

    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
