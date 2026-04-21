package common;

import java.text.DecimalFormat;

public class StringCommon {
    public static String convertDoubleToString(double d) {
        return new DecimalFormat("#").format(d);
    }

    public static String convertDoubleToStringWithComma(double d) {
        return new DecimalFormat("###,###").format(d);
    }
}
