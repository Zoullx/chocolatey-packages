function Controller()
{
    gui.setSilent(true);
}

Controller.prototype.CustomIntroductionPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function()
{
    var page = gui.currentPageWidget();
    var checkBox = gui.findChild(page, "RunItCheckBox");
    if (checkBox.checked) {
        checkBox.click();
    }
    gui.clickButton(buttons.FinishButton);
}