package net.mullvad.mullvadvpn.compose.dialog

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.size
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.lifecycle.compose.dropUnlessResumed
import com.ramcosta.composedestinations.annotation.Destination
import com.ramcosta.composedestinations.annotation.RootGraph
import com.ramcosta.composedestinations.result.EmptyResultBackNavigator
import com.ramcosta.composedestinations.result.ResultBackNavigator
import com.ramcosta.composedestinations.spec.DestinationStyle
import net.mullvad.mullvadvpn.R
import net.mullvad.mullvadvpn.compose.button.NegativeButton
import net.mullvad.mullvadvpn.compose.button.PrimaryButton
import net.mullvad.mullvadvpn.lib.theme.AppTheme
import net.mullvad.mullvadvpn.lib.theme.Dimens

@Preview
@Composable
private fun PreviewReportProblemNoEmailDialog() {
    AppTheme { ReportProblemNoEmail(EmptyResultBackNavigator()) }
}

@Destination<RootGraph>(style = DestinationStyle.Dialog::class)
@Composable
fun ReportProblemNoEmail(resultBackNavigator: ResultBackNavigator<Boolean>) {
    AlertDialog(
        onDismissRequest = dropUnlessResumed { resultBackNavigator.navigateBack() },
        icon = {
            Icon(
                painter = painterResource(id = R.drawable.icon_alert),
                contentDescription = null,
                modifier = Modifier.size(Dimens.dialogIconHeight),
                tint = MaterialTheme.colorScheme.error,
            )
        },
        text = {
            Text(
                text = stringResource(id = R.string.confirm_no_email),
                modifier = Modifier.fillMaxWidth(),
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurface,
            )
        },
        dismissButton = {
            PrimaryButton(
                modifier = Modifier.fillMaxWidth(),
                onClick = dropUnlessResumed { resultBackNavigator.navigateBack() },
                text = stringResource(id = R.string.back),
            )
        },
        confirmButton = {
            NegativeButton(
                modifier = Modifier.fillMaxWidth(),
                onClick = dropUnlessResumed { resultBackNavigator.navigateBack(result = true) },
                text = stringResource(id = R.string.send_anyway),
            )
        },
        containerColor = MaterialTheme.colorScheme.surface,
    )
}
