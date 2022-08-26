<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossingChallanPayment.aspx.cs" Inherits="GUI_Operations_Crossing_CrossingChallanPayment" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar" TagPrefix="pgb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript">
     var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
	/*************************************************************************************************************
            function For calculation
*************************************************************************************************************/

 function ChallanWise_Calc(Obj)
	    {
	             
	             Grid_Id="CrossingChallanDetail"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var TotAmountPayable=0,TotDeduction=0,TotNetAmt=0
                 var amountPayable=0,deduction=0,netPayable=0;
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
                           Check_Bx_ID=document.getElementById(GV_FRM_NM+"CHKDET") 
                           
                           amountPayable=document.getElementById(GV_FRM_NM+"txtAmountpayable") 
                           deduction=document.getElementById(GV_FRM_NM+"txtDeductions") 
                           netPayable=document.getElementById(GV_FRM_NM+"txtNetPayable")
                           
                           var IndTOTAmt=0
                           
                           if(Check_Bx_ID.checked)
                              {
                                document.getElementById(GV_FRM_NM+"txtNetPayable").value=rounditn(parseFloat(amountPayable.value)-parseFloat(deduction.value),2)
                                TotAmountPayable=rounditn(parseFloat(TotAmountPayable)+parseFloat(amountPayable.value),2)
                                TotDeduction=rounditn(parseFloat(TotDeduction)+parseFloat(deduction.value),2)
                                TotNetAmt=rounditn(parseFloat(TotNetAmt)+parseFloat(netPayable.value),2)
                                
                                if(document.getElementById(GV_FRM_NM+"txtNetPayable").value < 0)
                                    {
                                    alert("Deduction should not greater than Payable Amount....!!!!")
                                    document.getElementById(GV_FRM_NM+"txtDeductions").value = "0.00";
                                    document.getElementById(GV_FRM_NM+"txtNetPayable").value=document.getElementById(GV_FRM_NM+"txtAmountpayable").value;
                                    return false;
                                    }
                                
                              }
                       
                       
                      }
                      if(b<10)
                       {
                                    GV_FRM_NM1="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                       }
                       else
                        {
                                     GV_FRM_NM1="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                        }
                        document.getElementById(GV_FRM_NM1+"txtTotalAmountpayable").value =TotAmountPayable;
                        document.getElementById(GV_FRM_NM1+"txtTotalDeductions").value =TotDeduction;
                        document.getElementById(GV_FRM_NM1+"txtTotalNetPayable").value =TotNetAmt;
                        
                        document.getElementById("ctl00_MyCPH1_txtTotalAmountPayables").value=TotAmountPayable;
                        document.getElementById("ctl00_MyCPH1_txtTotalDeductions").value=TotDeduction;
                        document.getElementById("ctl00_MyCPH1_txtTotalNetPayables").value=TotNetAmt;
                        
    }
	
	/*************************************************************************************************************
             FUNCTION FOR NO OF DECIMAL VALUE
*************************************************************************************************************/

 function rounditn(Num,decplaces)
	{
		Places=decplaces
		if (Places > 0) 
			{
			
			if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
			{
			
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				var Rounder = Math.pow(10, Places);
				return Math.round(Num * Rounder) / Rounder;
			}
			else 
			{
				//alert("Hi")
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				else
				{  
					if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
						return Num.toString() +'0';	
					else
						return Num.toString();				   

				}
			}
			}
		else return Math.round(Num);
		
	}     
	
    </script>

    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
                BorderWidth="0">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center">
            Crossing challan payment
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Voucher No
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:Label ID="lblVoucherno" Text="System Generated..." runat="server" ForeColor="red"
                            Font-Bold="true"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
           Voucher Date
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:TextBox ID="txtVoucherDate" runat="server" BorderStyle="Groove" Width="60px"
                            Columns="8"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="a1">
                            <img alt="" src="../../images/calendar.jpg" border="0" />
                        </a><font class="blackfnt">dd/mm/yyyy </font>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true" ColumnSpan="4">
                        <asp:GridView ID="CrossingChallanDetail" runat="server" AutoGenerateColumns="False"
                            BorderWidth="0px" CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..."
                            FooterStyle-CssClass="boxbg" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left" Style="width: 9.0in"
                            ShowFooter="True">
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="left">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CHKDET" runat="server" onclick="javascript:ChallanWise_Calc(this)" />
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Crossing challan number" HeaderStyle-CssClass="blackfnt"
                                    FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                            <font class="blackfnt">
                                                <asp:Label ID="lblCrossingno" Text='<%# DataBinder.Eval(Container.DataItem,"CrossingChallanNo") %>'
                                                    runat="server"></asp:Label>
                                                    <asp:HiddenField ID="hdnVendorCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VendorCode") %>'/>
                                                    <asp:HiddenField ID="hdnVendorName" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VendorName") %>'/>
                                            </font>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Challan Date" HeaderStyle-CssClass="blackfnt"
                                    FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                            <font class="blackfnt">
                                                <asp:Label ID="lblChallanDate" Text='<%# DataBinder.Eval(Container.DataItem,"ChallanDt") %>'
                                                    runat="server"></asp:Label>
                                            </font>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount payable" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                                    FooterStyle-CssClass="bgbluegrey">
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtAmountpayable" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"NetPayable") %>'
                                                Width="60px" Enabled="false" BorderStyle="Groove" Style="text-align: right;"></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtTotalAmountpayable" runat="server" Enabled="false" Style="text-align: right;"
                                                BorderStyle="Groove" Text="0" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Deductions" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                                    FooterStyle-CssClass="bgbluegrey">
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtDeductions" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onblur="javascript:ChallanWise_Calc(this)" Style="text-align: right;" BorderStyle="Groove"
                                                Text="0.0" Width="60px"></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtTotalDeductions" runat="server" Enabled="false" Style="text-align: right;" Text="0.0"
                                                BorderStyle="Groove" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Net Payable" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                                    FooterStyle-CssClass="bgbluegrey">
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtNetPayable" runat="server" Style="text-align: right;" Enabled="false"
                                                BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"NetPayable") %>'
                                                Width="60px"></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtTotalNetPayable" Enabled="false" Style="text-align: right;" runat="server"
                                                Text="0.0" BorderStyle="Groove" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
           SUMMARY
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
                       Payment details 
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>
           Total Amount payable (+)
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtTotalAmountPayables" runat="server" BorderStyle="Groove" Enabled="false" Style="text-align: right;"
                            Width="70px"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
           Mode of payment
                    </asp:TableCell>
                    <asp:TableCell>
                       <asp:DropDownList ID="ddlPayMode" runat="server" Width="87px" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                <asp:ListItem>Cash</asp:ListItem>
                                <asp:ListItem>Bank</asp:ListItem>
                            </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>
           Total deductions (-)
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtTotalDeductions" runat="server" BorderStyle="Groove" Enabled="false" Style="text-align: right;"
                            Width="70px"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
           Cheque Number
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtChqNo" runat="server" BorderStyle="Groove" Style="text-align: right;"
                            Width="70px"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>
           Net payable (-)
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtTotalNetPayables" runat="server" BorderStyle="Groove" Enabled="false" Style="text-align: right;"
                            Width="70px"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
           Date
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtChqDate" runat="server" BorderStyle="Groove" Style="text-align: right;"
                            Width="70px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChqDate,'anchor11','dd/MM/yyyy'); return false;"
                            name="anchor11" id="a2">
                            <img alt="" src="../../images/calendar.jpg" border="0" />
                        </a><font class="blackfnt">dd/mm/yyyy </font>
                            
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>
          
                    </asp:TableCell>
                    <asp:TableCell>
         
                    </asp:TableCell>
                    <asp:TableCell>
                    <asp:Label ID="lblCash_Bank" runat="server" Text="Cash"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                       <asp:DropDownList ID="ddrBankaccode" runat="server">
                            </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="4">
                        <center>
                            <asp:Button ID="btnsubmit" Text="Submit" BorderStyle="Groove" runat="server"
                                CssClass="blackfnt" OnClick="btnsubmit_Click" />
                        </center>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgb:ProgressBar ID="ProgressBar1" runat="server" />
</asp:Content>
