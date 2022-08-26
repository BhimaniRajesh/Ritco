<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AcknowledgeFMDocumentsMain_Det_new.aspx.cs" Inherits="GUI_Operations_FM_AcknowledgeFMDocumentsMain_Det_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript">
    
    function checkall(obj)
    {
    debugger
        var idx="<%=strFMType %>";
        var ctrlPrefix = "";
        if(idx=="<%=FMUtility.POD %>")
            ctrlPrefix =  "ctl00_MyCPH1_dgDocket_ctl";
        if(idx=="<%=FMUtility.Bill %>")
            ctrlPrefix =  "ctl00_MyCPH1_dg_bill_ctl";
        if(idx=="<%=FMUtility.COD_DOD %>")
            ctrlPrefix =  "ctl00_MyCPH1_gv_coddod_ctl";
            
        var mTotalRecords = "<%=intTotalRecords %>"
        for (var i=0; i < mTotalRecords; i++)
        {
            j = i + 2;

             if(j < 10)
            {
                chk_ind = ctrlPrefix + "0" + j + "_chkOrderNo"
                //alert(mDerivedControlName)
            }
            else
            {
                chk_ind = ctrlPrefix + j + "_chkOrderNo"
            }
            
            var len=chk_ind.length;
            var id2=chk_ind.substring(0,len-10);
            
            var txt=document.getElementById(id2+"hdncomm");                            
          
            if(document.getElementById(chk_ind).disabled==false)
            {
                if(obj.checked==true)
                {
                    document.getElementById(chk_ind).checked=true;
                }
                else
                {
                     document.getElementById(chk_ind).checked=false;
                }
            }
        }
    }

    function fsubmit()
	{
	    var idx="<%=strFMType %>";	
	    var ctrlPrefix = "";
        if(idx=="<%=FMUtility.POD %>")
            ctrlPrefix =  "ctl00_MyCPH1_dgDocket";
        if(idx=="<%=FMUtility.Bill %>")
            ctrlPrefix =  "ctl00_MyCPH1_dg_bill";
        if(idx=="<%=FMUtility.COD_DOD %>")
            ctrlPrefix =  "ctl00_MyCPH1_gv_coddod";
            
	    var GV_frmname= ctrlPrefix+"_";
	
        var GV=document.getElementById(ctrlPrefix);
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
        }//for loop ENDS HERE	    
        if(chkcount==0)
        {
            alert("No Row Selected..........");
            return false;
        }
        click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);
        //alert(click_count)

        if(click_count > 0)
		{
			alert("Sorry... You cannot click twice !!!");
			return false;
		}  
		else
		{
		//alert(click_count)
			click_count=click_count+1;
			//alert(click_count)
			document.getElementById("ctl00_MyCPH1_click_count").value=click_count;
			//alert(click_count)
		
			//document.frm.action = "DirectBAPayment_Submit.asp"  
			//document.frm.method = "post"
			//document.frm.submit()   
	    }    
		alert("Submitted.....");
	}

</script>
  <asp:HiddenField ID="click_count" Value="0" runat="server" />
    <table border="0" align="left" cellpadding="0" cellspacing="0" class="blackfnt">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operations </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Acknowledge Receipt </strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
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
                <center>
                    <br />
                    <table border="0" class="boxbg" cellspacing="1" cellpadding="1" style="width: 8.0in">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4" style="height: 20px;">
                                <label class="blackfnt">
                                    <b>FM Details </b>
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    FM Number:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label CssClass="blackboldfnt" ID="lblfmno" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    FM Date:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfmdt" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Manual FM Number:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblManualfmno" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    FM Entry Date:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfmEntrydt" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Forward Document To:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfmFWDto" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Customer/Location:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfm_cust_location" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Document Type:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfm_doc_typ" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Courier Name:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfmCouriour" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Way Bill No.:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfm_wayBillno" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Way Bill Date:
                                </label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblfm_wayBilldate" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <asp:GridView ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2" GridLines="None" BorderWidth="0"
                        HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" CssClass="boxbg" FooterStyle-CssClass="boxbg" Width="8.0in" 
                        AutoGenerateColumns="false"  OnRowDataBound="GV_D_RowDataBound"
                        EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:TemplateField >
                            <HeaderTemplate>
                                <center>
                                    <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this)" />
                                    <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                                </center>
                            </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkOrderNo" runat="server" class="input" />
                                    <asp:HiddenField ID="hdncomm" Value='<% #DataBinder.Eval(Container.DataItem, "ID")%>'
                                        runat="server" />
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="SR.NO.">
                                        <ItemTemplate>PageSize="25"
                                           <%-- <asp:CheckBox ID="chkOrderNo" runat="server" class="input" />
                                          
                                             OnClientClick="javascript:return fsubmit()" 
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
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
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblorgdest" Text="Origin - Destination" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblorgdest_val" Text='<% #DataBinder.Eval(Container.DataItem, "Orgn_Dest")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblfromto" Text="From - TO" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblfromto_val" Text='<% #DataBinder.Eval(Container.DataItem, "From_To")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblamt" Text="Amount" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblAmt_val" Text='<% #DataBinder.Eval(Container.DataItem, "Amount")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldeldt" Text="Dely. Date" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldeldt_val" Text='<% #DataBinder.Eval(Container.DataItem, "deldt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle BackColor="white" />
                        <AlternatingRowStyle BackColor="#f7f7f7" />
                        <PagerStyle HorizontalAlign="Center" BackColor="white" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    <asp:GridView ID="dg_bill" runat="server" AutoGenerateColumns="False" CellSpacing="1" 
                            CellPadding="2" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false"
                            PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                            PagerSettings-Mode="NumericFirstLast" PagerSettings-FirstPageText="[First]"
                            PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">                                
                            <Columns>
                                <asp:TemplateField >
                                    <HeaderTemplate>
                                        <center>
                                            <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this)" />
                                        </center>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkOrderNo" runat="server" />
                                        <asp:HiddenField ID="hdncomm" Value='<% #DataBinder.Eval(Container.DataItem, "ID")%>' runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" HorizontalAlign="Center"/>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sr No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillNo" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "Bill_No")  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Manual Bill No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblManualBillNo" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "Manual_Bill_No")  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillDate" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "Bill_Date")  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Billing Party">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillingParty" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "Billing_Party")  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBillAmt" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "Bill_Amount")  %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White"  Wrap="false" HorizontalAlign="Right"/>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Submission Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubLoc" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "Submission_Location")  %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>                                    
                            </Columns>
                            <RowStyle BackColor="White"  Wrap="false" />
                            <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" />
                            <PagerStyle HorizontalAlign="Center" BackColor="White" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <EmptyDataRowStyle Width="800px" BackColor="white" />
                        </asp:GridView>   
                        <asp:GridView ID="gv_coddod" runat="server" CellSpacing="1" CellPadding="2" GridLines="None" BorderWidth="0"
                            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" CssClass="boxbg" FooterStyle-CssClass="boxbg" Width="8.0in" 
                            AutoGenerateColumns="false"  OnRowDataBound="GV_D_RowDataBound"
                            EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:TemplateField >
                            <HeaderTemplate>
                                <center>
                                    <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this)" />
                                </center>
                            </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkOrderNo" runat="server" class="input" />
                                    <asp:HiddenField ID="hdncomm" Value='<% #DataBinder.Eval(Container.DataItem, "ID")%>'
                                        runat="server" />
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="COD/DOD No">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldocumentno" Text='<% #DataBinder.Eval(Container.DataItem, "documentno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="COD/DOD Date">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldocumentdt" Text='<% #DataBinder.Eval(Container.DataItem, "documentdate")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblorgdest" Text="Origin - Destination" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblorgdest_val" Text='<% #DataBinder.Eval(Container.DataItem, "Orgn_Dest")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblfromto" Text="From - TO" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblfromto_val" Text='<% #DataBinder.Eval(Container.DataItem, "From_To")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblamt" Text="Amount" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblAmt_val" Text='<% #DataBinder.Eval(Container.DataItem, "Amount")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldeldt" Text="Dely. Date" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldeldt_val" Text='<% #DataBinder.Eval(Container.DataItem, "deldt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle BackColor="white" />
                        <AlternatingRowStyle BackColor="#f7f7f7" />
                        <PagerStyle HorizontalAlign="Center" BackColor="white" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    <br />
                    <asp:Button ID="btnUpdt" OnClick="btnUpdt_Click"  OnClientClick="javascript:return fsubmit()"  runat="server" Text="Receive FM" />
                    <br />
                    <asp:Label Visible="false" ID="lblerrro" runat="server"></asp:Label>
                </center>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
