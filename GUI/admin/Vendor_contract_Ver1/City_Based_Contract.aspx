<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" 
    CodeFile="City_Based_Contract.aspx.cs" Inherits="GUI_admin_Vendor_contract_Ver1_City_Based_Contract" %>
 <%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="uc1" %>   
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script type="text/javascript" language="javascript" src="Vendor_Contract.js"></script>
    <script type="text/javascript" language="javascript">
            
        function openPopupCity(ctrlId) 
        {
            window.open("frm_Popup_City.aspx?CtrlID="+ctrlId, null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
        }
        
        function checkOnSubmit()
        {        
            var grid =  document.getElementById("ctl00_MyCPH1_GV_City_Matrix");
            var len=parseInt(grid.rows.length);
            var pref="";
            var cnt=0;
            for(var i=2;i<=len;i++)
            {
                if(i<10)
                    pref = "ctl00_MyCPH1_GV_City_Matrix_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_GV_City_Matrix_ctl"+ i + "_";
                
                var ChkInd = document.getElementById(pref+"ChkInd");
                var Txt_FromCity = document.getElementById(pref+"Txt_FromCity");
                var Txt_ToCity = document.getElementById(pref+"Txt_ToCity");
                var Ddl_Mode = document.getElementById(pref+"Ddl_Mode");
                var Ddl_FTL_Type = document.getElementById(pref+"Ddl_FTL_Type");
                var Ddl_Rate_Type = document.getElementById(pref+"Ddl_Rate_Type");
                var Txt_MinChg = document.getElementById(pref+"Txt_MinChg");
                var Txt_MaxChg = document.getElementById(pref+"Txt_MaxChg");
                var Txt_Rate = document.getElementById(pref+"Txt_Rate");
                
                if(ChkInd.checked==true)
                {
                    cnt++;
                    if(MyTrim(Txt_FromCity.value)=="")
                    {
                        alert("Please Select From City");
                        Txt_FromCity.focus();
                        return false;
                    }
                    if(MyTrim(Txt_ToCity.value)=="")
                    {                        
                        alert("Please Select To City");
                        Txt_ToCity.focus();
                        return false;
                    }
                    if(MyTrim(Txt_FromCity.value)!="" && MyTrim(Txt_ToCity.value)!="")
                    {
                        if(MyTrim(Txt_FromCity.value)==MyTrim(Txt_ToCity.value))
                        {
                            alert("To City can not be same as From City.");
                            Txt_FromCity.focus();
                            return false;
                        }
                    }
                    if(Ddl_Mode.value=="")
                    {
                        alert("Please Select From Mode");
                        Ddl_Mode.focus();
                        return false;
                    }    
                    if(Ddl_FTL_Type.value=="")
                    {
                        if(Ddl_City.value=="S")
                        {
                            alert("Please Select Type of Movement");
                            Ddl_FTL_Type.focus();
                            return false;
                        }
                    }
                    if(Txt_MinChg.value=="")
                    {
                        alert("Please Enter Minimum Charge");
                        Txt_MinChg.focus();
                        return false;
                    }
                    else
                    {
                        var rt = parseFloat(Txt_MinChg.value);
                        if(rt==0.00)
                        {
                            //alert("Minimum charge can not be zero");
                            //Txt_MinChg.focus();
                            //return false;
                        }
                    }
                    if(Txt_MaxChg.value=="")
                    {
                        alert("Please Enter Maximum Charge");
                        Txt_MaxChg.focus();
                        return false;
                    }
                    else
                    {
                        var rt = parseFloat(Txt_MaxChg.value);
                        if(rt==0.00)
                        {
                            //alert("Maximum charge can not be zero");
                            //Txt_MaxChg.focus();
                            //return false;
                        }
                    }
                    if(Ddl_Rate_Type.value=="")
                    {
                        alert("Please Select Rate Type");
                        Ddl_Rate_Type.focus();
                        return false;
                    }
                    if(Txt_Rate.value=="")
                    {
                        alert("Please Enter Rate");
                        Txt_Rate.focus();
                        return false;
                    }
                    else
                    {
                        if(Txt_MinChg.value==Txt_MaxChg.value)
                        {
                            //Allow 0.00
                        }   
                        else
                        {
                            var rt = parseFloat(Txt_Rate.value);
                            if(rt==0.00)
                            {
                                //alert("Rate can not be zero");
                                //Txt_Rate.focus();
                                //return false;
                            }
                        }              
                    }
                    for(var j=2;j<len;j++)
                    {
                        var jref="";
                        if(j<10)
                            jref = "ctl00_MyCPH1_GV_City_Matrix_ctl0" + j + "_";
                        else
                            jref = "ctl00_MyCPH1_GV_City_Matrix_ctl"+ j + "_";   
                        
                        if(i!=j)
                        {
                           var jTxt_FromCity = document.getElementById(jref+"Txt_FromCity");
                           var jTxt_ToCity = document.getElementById(jref+"Txt_ToCity");
                           var jDdl_Mode = document.getElementById(jref+"Ddl_Mode");
                           var jDdl_FTL_Type = document.getElementById(jref+"Ddl_FTL_Type");
                           if(jTxt_ToCity.value != "" && jTxt_FromCity.value != "" && jDdl_FTL_Type.value != "" && jDdl_Mode.value != "")
                           {
                               if(MyTrim(jTxt_FromCity.value)==MyTrim(Txt_FromCity.value) && 
                                  MyTrim(jTxt_ToCity.value)==MyTrim(Txt_ToCity.value) && 
                                  jDdl_FTL_Type.value==Ddl_FTL_Type.value && jDdl_Mode.value == Ddl_Mode.value)
                               {
                                   alert("Record Already Exist. Please Select Another From City, To City, Mode or Type of Movement");                                    
                                    jTxt_FromCity.focus();
                                    return false;
                               }
                           }                            
                        } // i!=j
                        
                    } //  J loop
                
                } // Check of YES/NO        

            } // I loop   
            if(cnt==0)
            {
                alert("No Record Selected To Save.");
                return false;                    
            }
            else
                return true;
        }
        
    </script>
    <div>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <br />
                            <table border="0" style="width: 5.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <b>Vendor Contract Step 2 : City Based Contract</b>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td colspan="2" align="Left">
                                        <asp:Label ID="Lbl_ADD_Edit" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        Vendor Type:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_VendorType" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        Vendor Code & Name:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_Vendor" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <b>City Based Contract Matrix</b>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        <font class="blackfnt">Enter No. Of Rows</font>
                                    </td>
                                    <td align="Left">
                                        <asp:TextBox ID="Txt_TotRows" runat="server" Text="1" CssClass="blackfnt" BorderStyle="Groove"
                                            Width="60" Style="text-align: right" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                        <asp:Button ID="Btn_AddRow" OnClick="AddGridRow" runat="server" CssClass="blackfnt"
                                            Text="Add ROW" UseSubmitBehavior="False" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left" colspan="2">
                                        <asp:GridView Visible="true" align="left" ID="GV_City_Matrix" runat="server" BorderWidth="0"
                                            CellPadding="5" CellSpacing="1" HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="false" RowStyle-CssClass="dgRowStyle"
                                            AllowPaging="false" CssClass="boxbg" AutoGenerateColumns="false" FooterStyle-CssClass="boxbg"
                                            OnRowDataBound="GV_City_Matrix_RowDataBound" EmptyDataText="No Records Found...">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_City_Matrix','ChkAll','ChkInd','N')" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                            runat="server">
                                                        </asp:Label>
                                                        <asp:CheckBox ID="ChkInd" runat="server" onclick="javascript:Check_Ind('GV_City_Matrix','ChkAll','ChkInd')" />
                                                        <asp:HiddenField ID="hidID" runat="server" Value="0"/>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="From City" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_FromCity" Text="" runat="server" CssClass="blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                                        <input type="button" value="..." runat="server"  class="blackfnt" BorderStyle="Groove" id="btnFromCity" />
                                                        <ajaxToolkit:AutoCompleteExtender ID="extFromCity" runat="server" MinimumPrefixLength="1" ServiceMethod="GetCityList"
                                                                ServicePath="../../services/WebService.asmx" TargetControlID="Txt_FromCity" >
                                                        </ajaxToolkit:AutoCompleteExtender>                                      
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="To City" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_ToCity" Text="" runat="server" CssClass="blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                                        <input type="button" value="..." runat="server"  class="blackfnt" BorderStyle="Groove" id="btnToCity" />
                                                        <ajaxToolkit:AutoCompleteExtender ID="extToCity" runat="server" MinimumPrefixLength="1"  ServiceMethod="GetCityList"
                                                                ServicePath="../../services/WebService.asmx" TargetControlID="Txt_ToCity">
                                                        </ajaxToolkit:AutoCompleteExtender>    
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Mode" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Mode" runat="server" AutoPostBack="true"  CssClass="blackfnt" OnSelectedIndexChanged="Ddl_Mode_OnSelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type of Movement" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_FTL_Type" runat="server" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Minimum" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_MinChg" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="12"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"  onchange="javascript:this.value=roundNumber(this.value,2);"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maximum" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_MaxChg" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="12"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"  onchange="javascript:this.value=roundNumber(this.value,2);"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rate Type" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Rate_Type" runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Text="Per Kg" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rate" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_Rate" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="8"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onchange="javascript:this.value=roundNumber(this.value,2);"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                                Width="200" />
                                            <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                                            <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                                Mode="NumericFirstLast" />
                                            <HeaderStyle Font-Bold="true" CssClass="dgHeaderStyle" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="false" />
                                            <FooterStyle CssClass="boxbg" Wrap="false" Width="200" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Submit City Based Matrix Data" OnClientClick="javascript:return checkOnSubmit();" OnClick="Submit_Data" />
                                         &nbsp;
                                        <asp:Button ID="Btn_SubmitWithoutSave" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Continue without saving >>" OnClick="Submit_WithoutSaving" />
                                        <uc1:ProgressBar ID="ProgressBar1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

