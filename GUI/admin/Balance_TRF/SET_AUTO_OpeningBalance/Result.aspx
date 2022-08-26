<%@ Page Language="C#"    AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <script language="JavaScript" type="text/javascript">
        var Frm_name="ctl00$MyCPH1$"
        function checkall(obj,type)
           {
            
           /// alert("hi...")
             
                GridId="GV_Records";
            
             var mTotalRecords = "<%=intTotalRecords %>"
            
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$Chkcust"
                                
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + j + "$Chkcust"
                               
                            }
                            
                            if(obj.checked==true)
                            {
                            document.getElementById(chk_ind).checked=true;
                            }
                            else
                            {
                             document.getElementById(chk_ind).checked=false;
                            }
                       }
                   checkall_ind()
            }
                     function checkall_ind(type)
            {
              //alert("hi..")
            
                GridId="GV_Records";
             
                var mTotalRecords = "<%=intTotalRecords %>";
                var chk_cnt=0;
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00_MyCPH1_"+GridId+"_ctl" + "0" + j + "_Chkcust"
                                Frm_Name="ctl00_MyCPH1_"+GridId+"_ctl0" + j + "_"
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00_MyCPH1_"+GridId+"_ctl" + j + "_Chkcust"
                                Frm_Name="ctl00_MyCPH1_"+GridId+"_ctl" + j + "_"
                               
                            }
                            var ind_debit=0,ind_credit=0,Ind_opn_debit=0,Ind_opn_credt=0;
                               var Tot_debit=0,Tot_credit=0;
                               if(document.getElementById(chk_ind).checked==true)
                               {
                                                 chk_cnt=chk_cnt+1
                                                
                                               Tot_debit = parseFloat(document.getElementById(Frm_Name+"opn_debit").innerText)+parseFloat(document.getElementById(Frm_Name+"Curr_Debit").innerText)
                                               Tot_credit = parseFloat(document.getElementById(Frm_Name+"opn_credit").innerText)+parseFloat(document.getElementById(Frm_Name+"Curr_credit").innerText)
                                               if (parseFloat(Tot_debit)>parseFloat(Tot_credit))
                                               {
                                                   Tot_debit=Tot_debit-Tot_credit
                                                   Tot_credit=0
                                                    document.getElementById(Frm_Name+"TxtDebit").value=rounditn(Tot_debit,2)
                                                    document.getElementById(Frm_Name+"TxtCredit").value="0.00"
                                               }  
                                               if (parseFloat(Tot_debit)<parseFloat(Tot_credit))
                                               {
                                                   Tot_credit=Tot_credit-Tot_debit 
                                                   Tot_debit=0
                                                     document.getElementById(Frm_Name+"TxtDebit").value="0.00"
                                                    document.getElementById(Frm_Name+"TxtCredit").value=rounditn(Tot_credit,2)
                                               } 
                                               if (parseFloat(Tot_debit)==parseFloat(Tot_credit))
                                               {
                                                   Tot_credit=0
                                                   Tot_debit=0
                                                    document.getElementById(Frm_Name+"TxtDebit").value="0.00"
                                                    document.getElementById(Frm_Name+"TxtCredit").value="0.00"
                                               }      
                                }  
                                else
                                {
                                                    document.getElementById(Frm_Name+"TxtDebit").value="0.00"
                                                    document.getElementById(Frm_Name+"TxtCredit").value="0.00"
                               }                
                       }
                        if(parseFloat(chk_cnt)==parseFloat(mTotalRecords))
                        {
                            document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl01$chkall").checked=true
                        }
                        else
                        {
                            document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl01$chkall").checked=false
                        }
                     
            }
    function onSubmit()
    {
                GridId="GV_Records";
                Checked_One="N"
                var mTotalRecords = "<%=intTotalRecords %>";
                var chk_cnt=0;
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00_MyCPH1_"+GridId+"_ctl" + "0" + j + "_Chkcust"
                                Frm_Name="ctl00_MyCPH1_"+GridId+"_ctl0" + j + "_"
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00_MyCPH1_"+GridId+"_ctl" + j + "_Chkcust"
                                Frm_Name="ctl00_MyCPH1_"+GridId+"_ctl" + j + "_"
                               
                            }
                            
                               if(document.getElementById(chk_ind).checked==true)
                               {
                                   Checked_One="Y"
                               }
                        }
                        
                        if(Checked_One=="N")
                        {
                            alert("Plz Select atleast One Record")
                            return false;
                        }
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                             
                                Frm_Name="ctl00_MyCPH1_"+GridId+"_ctl0" + j + "_"
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                Frm_Name="ctl00_MyCPH1_"+GridId+"_ctl" + j + "_"
                               
                            }
                             document.getElementById(Frm_Name+"TxtDebit").disabled=false
                             document.getElementById(Frm_Name+"TxtCredit").disabled=false
                        }      
    }
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
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Cash & Bank Report</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="../../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" runat="server" id="TBL_CRI"   horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 7.0in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            RO</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Location</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Groups</td>
                        <td>
                            <asp:Label runat="server" ID="lblGrp"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Accounts</td>
                        <td>
                            <asp:Label runat="server" ID="LBLSUBRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            <asp:Label runat="server" ID="lblCust_vend_typ"></asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblCust_vend"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
                <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left">
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:Button ID="Button1"  Visible="false" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
         <tr>
            <td valign="top"> 
            <asp:Label ID="LblNote" runat="server" Text=" " CssClass="redfnt"  Font-Bold="true"  ></asp:Label>
              <br />
                <br />
            </td>
          
        </tr>
        <tr>
            <td valign="top">
           
                <asp:GridView ID="GV_Records" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                         PagerStyle-HorizontalAlign="left" CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  AllowPaging="false"  AllowSorting="False" 
                         AutoGenerateColumns="false" PEmptyDataText="No Records Found..." >
                     <PagerStyle VerticalAlign="Bottom"/>
                      <Columns>
                    
                       <asp:TemplateField>
                     <HeaderTemplate>
                    <center>
                    <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this,'C')"   />
            
                    </center>
                    </HeaderTemplate>

                     <HeaderStyle  HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                       <ItemStyle CssClass="blackfnt"  Wrap="false"/>
                                   <ItemTemplate>
                                    
                                    <asp:CheckBox ID="Chkcust" runat="server"  onclick="javascript:checkall_ind('C')"  />
                                     <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                     </ItemTemplate>
                     </asp:TemplateField>
                     
                       <asp:TemplateField>
                        <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblCustcode"  CssClass="blackfnt" text ='Customer Code/Name' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" Wrap="false"  />
                                   <ItemTemplate>
                                    
                                   <asp:Label runat="server" ID="Custcode"  CssClass="blackfnt"  ><%# DataBinder.Eval(Container.DataItem,"Cd") %>:<%# DataBinder.Eval(Container.DataItem,"NM") %></asp:Label>
                                    <asp:HiddenField ID="hnd_Custcode"  runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Cd") %>' />
                                    <asp:HiddenField ID="hnd_Loccode"  runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"s_Typ") %>' />
                                     </ItemTemplate>
                     </asp:TemplateField>
                    <asp:TemplateField>
                      <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblAcctcode"  CssClass="blackfnt" text ='Location' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" Wrap="false" />
                                   <ItemTemplate>
                                    
                                   <asp:Label runat="server" ID="Acctcode"  CssClass="blackfnt" text ='<%# DataBinder.Eval(Container.DataItem,"M_ACD") %>' ></asp:Label>
                                    
                                     </ItemTemplate>
                     </asp:TemplateField>
                       <asp:TemplateField>
                       <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblDebit"  CssClass="blackfnt" text ='Opening Debit' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                   <ItemTemplate>
                                    <%--<asp:TextBox ID="TxtDebit"   onkeypress="javascript:return validFloat(event)"  onblur="javascript:this.value=rounditn(this.value,2)"  Text='<%# DataBinder.Eval(Container.DataItem,"opn_debit") %>' runat="server" MaxLength="10" Columns="8" CssClass="blackfnt" ></asp:TextBox>--%>
                                     <asp:Label runat="server" ID="opn_debit"  CssClass="blackfnt" text ='<%# DataBinder.Eval(Container.DataItem,"opn_debit") %>' ></asp:Label>
                                   </ItemTemplate>
                     </asp:TemplateField>
                   
                     
                       <asp:TemplateField>
                       <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblCredit41"  CssClass="blackfnt" text ='Opening Credit' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                   <ItemTemplate>
                                    <%--<asp:TextBox ID="TxtCredit"  onkeypress="javascript:return validFloat(event)"   onblur="javascript:this.value=rounditn(this.value,2)"  Text='<%# DataBinder.Eval(Container.DataItem,"opn_credit") %>' runat="server" MaxLength="10" Columns="8" CssClass="blackfnt" ></asp:TextBox>--%>
                                     <asp:Label runat="server" ID="opn_credit"  CssClass="blackfnt" text ='<%# DataBinder.Eval(Container.DataItem,"opn_credit") %>' ></asp:Label>
                                   </ItemTemplate>
                     </asp:TemplateField>
                      <asp:TemplateField>
                       <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblCredit"  CssClass="blackfnt" text ='Current Debit' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                   <ItemTemplate>
                                    <%--<asp:TextBox ID="TxtCredit"  onkeypress="javascript:return validFloat(event)"   onblur="javascript:this.value=rounditn(this.value,2)"  Text='<%# DataBinder.Eval(Container.DataItem,"opn_credit") %>' runat="server" MaxLength="10" Columns="8" CssClass="blackfnt" ></asp:TextBox>--%>
                                     <asp:Label runat="server" ID="Curr_Debit"  CssClass="blackfnt" text ='<%# DataBinder.Eval(Container.DataItem,"Curr_Debit") %>' ></asp:Label>
                                   </ItemTemplate>
                     </asp:TemplateField>
                     
                     <asp:TemplateField>
                       <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblCredit2"  CssClass="blackfnt" text ='Current Credit' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                   <ItemTemplate>
                                    <%--<asp:TextBox ID="TxtCredit"  onkeypress="javascript:return validFloat(event)"   onblur="javascript:this.value=rounditn(this.value,2)"  Text='<%# DataBinder.Eval(Container.DataItem,"opn_credit") %>' runat="server" MaxLength="10" Columns="8" CssClass="blackfnt" ></asp:TextBox>--%>
                                     <asp:Label runat="server" ID="Curr_credit"  CssClass="blackfnt" text ='<%# DataBinder.Eval(Container.DataItem,"Curr_credit") %>' ></asp:Label>
                                   </ItemTemplate>
                     </asp:TemplateField>
                     
                     <asp:TemplateField>
                       <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblCredit4"  CssClass="blackfnt" text ='Closing Debit' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                   <ItemTemplate>
                                     <asp:TextBox ID="TxtDebit"   Enabled="false"  Text='0.00' runat="server" MaxLength="12" Columns="10" CssClass="blackfnt" ></asp:TextBox> 
                                      
                                   </ItemTemplate>
                     </asp:TemplateField>
                     
                     <asp:TemplateField>
                       <HeaderTemplate>
                        <center>
                         <asp:Label runat="server" ID="lblCredit5"  CssClass="blackfnt" text ='Closing Debit' ></asp:Label>
                         </center>
                       </HeaderTemplate>
                              <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                   <ItemTemplate>
                                  <asp:TextBox ID="TxtCredit" Enabled="false"   Text='0.00' runat="server" MaxLength="12" Columns="10" CssClass="blackfnt" ></asp:TextBox>
                                     
                                   </ItemTemplate>
                     </asp:TemplateField>
                     
                    </Columns>
                                                                 
                                                                
                                              
                                        </asp:GridView> 
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
                <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left">
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:HiddenField ID="Count" runat="server" />
                            <asp:Button ID="Button2"  CssClass="blackfnt" Text="" runat="server" Width="300" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
