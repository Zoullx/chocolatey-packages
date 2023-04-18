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
    gui.clickButton(buttons.FinishButton);
}