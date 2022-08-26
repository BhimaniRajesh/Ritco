<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupbranch.aspx.cs" Inherits="popupbranch" %>


<link href="../../../GUI/admin/CityMaster/include/style.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BranchList</title>
    
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
            var mNo = "<%=strQSParam %>"
            if(mNo == 1)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc1.value = objLocation.value
            }
            else if(mNo == 2)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc2.value = objLocation.value
            }
            else if(mNo == 3)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc3.value = objLocation.value
            }
            else if(mNo == 4)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc4.value = objLocation.value
            }
            else if(mNo == 5)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc5.value = objLocation.value
            }
            else if(mNo == 6)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc6.value = objLocation.value
            }
            else if(mNo == 7)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc7.value = objLocation.value
            }
            else if(mNo == 8)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc8.value = objLocation.value
            }
            else if(mNo == 9)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc9.value = objLocation.value
            }
            else if(mNo == 10)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc10.value = objLocation.value
            }
            else if(mNo == 11)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc1.value = objLocation.value
            }
            else if(mNo == 12)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc2.value = objLocation.value
            }
            else if(mNo == 13)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc3.value = objLocation.value
            }
            else if(mNo == 14)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc4.value = objLocation.value
            }
            else if(mNo == 15)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc5.value = objLocation.value
            }
            else if(mNo == 16)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc6.value = objLocation.value
            }
            else if(mNo == 17)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc7.value = objLocation.value
            }
            else if(mNo == 18)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc8.value = objLocation.value
            }
            else if(mNo == 19)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc9.value = objLocation.value
            }
            else if(mNo == 20)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRdDelLoc10.value = objLocation.value
            }
            else if(mNo == 21)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc1.value = objLocation.value
            }
            else if(mNo == 22)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc2.value = objLocation.value
            }
            else if(mNo == 23)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc3.value = objLocation.value
            }
            else if(mNo == 24)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc4.value = objLocation.value
            }
            else if(mNo == 25)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc5.value = objLocation.value
            }
            else if(mNo == 26)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc6.value = objLocation.value
            }
            else if(mNo == 27)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc7.value = objLocation.value
            }
            else if(mNo == 28)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc8.value = objLocation.value
            }
            else if(mNo == 29)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc9.value = objLocation.value
            }
            else if(mNo == 30)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirBkLoc10.value = objLocation.value
            }
            else if(mNo == 31)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc1.value = objLocation.value
            }
            else if(mNo == 32)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc2.value = objLocation.value
            }
            else if(mNo == 33)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc3.value = objLocation.value
            }
            else if(mNo == 34)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc4.value = objLocation.value
            }
            else if(mNo == 35)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc5.value = objLocation.value
            }
            else if(mNo == 36)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc6.value = objLocation.value
            }
            else if(mNo == 37)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc7.value = objLocation.value
            }
            else if(mNo == 38)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc8.value = objLocation.value
            }
            else if(mNo == 39)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc9.value = objLocation.value
            }
            else if(mNo == 40)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAirDlLoc10.value = objLocation.value
            }
            else if(mNo == 41)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc1.value = objLocation.value
            }
            else if(mNo == 42)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc2.value = objLocation.value
            }
            else if(mNo == 43)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc3.value = objLocation.value
            }
            else if(mNo == 44)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc4.value = objLocation.value
            }
            else if(mNo == 45)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc5.value = objLocation.value
            }
            else if(mNo == 46)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc6.value = objLocation.value
            }
            else if(mNo == 47)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc7.value = objLocation.value
            }
            else if(mNo == 48)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc8.value = objLocation.value
            }
            else if(mNo == 49)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc9.value = objLocation.value
            }
            else if(mNo == 50)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlBkLoc10.value = objLocation.value
            }
            else if(mNo == 51)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc1.value = objLocation.value
            }
            else if(mNo == 52)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc2.value = objLocation.value
            }
            else if(mNo == 53)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc3.value = objLocation.value
            }
            else if(mNo == 54)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc4.value = objLocation.value
            }
            else if(mNo == 55)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc5.value = objLocation.value
            }
            else if(mNo == 56)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc6.value = objLocation.value
            }
            else if(mNo == 57)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc7.value = objLocation.value
            }
            else if(mNo == 58)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc8.value = objLocation.value
            }
            else if(mNo == 59)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc9.value = objLocation.value
            }
            else if(mNo == 60)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtRlDelLoc10.value = objLocation.value
            }
        }    
        
        
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="350px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("loccode") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="loccode" HeaderText="Branch Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="locname" HeaderText="Branch Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    
        &nbsp;
    <div>
        &nbsp;</div>
    </form>
</body>
</html>


                             
