
        
        function Disable(reportViewerID) {
            var exportList = document.getElementById(reportViewerID+'_ctl01_ctl05_ctl00');
            exportList.options.length = 0;
            exportList.innerHTML = '';
            appendOption(exportList, 'Select a format','');
            appendOption(exportList, 'Excel', 'EXCEL');
            appendOption(exportList, 'PDF', 'PDF');
            appendOption(exportList, 'CSV', 'CSV');
        }
        function appendOption(listCtrl, optionText, optionValue) {
            var newOption = document.createElement('option');
            newOption.text = optionText;
            newOption.value = optionValue;
            try {
                listCtrl.add(newOption, null);
            }
            catch (ex) {
                listCtrl.add(newOption);
            }
        }
   
