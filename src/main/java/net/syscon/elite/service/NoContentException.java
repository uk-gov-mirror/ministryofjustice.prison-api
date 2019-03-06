package net.syscon.elite.service;

import java.util.function.Supplier;

public class NoContentException extends RuntimeException implements Supplier<net.syscon.elite.service.NoContentException> {
    private static final String DEFAULT_MESSAGE_FOR_ID_FORMAT = "Resource has no content.";

    public static net.syscon.elite.service.NoContentException withId(long id) {
        return withId(String.valueOf(id));
    }

    public static net.syscon.elite.service.NoContentException withId(String id) {
        return new net.syscon.elite.service.NoContentException(String.format(DEFAULT_MESSAGE_FOR_ID_FORMAT, id));
    }

    public static net.syscon.elite.service.NoContentException withMessage(String message) {
        return new net.syscon.elite.service.NoContentException(message);
    }

    public static net.syscon.elite.service.NoContentException withMessage(String message, Object... args) {
        return new net.syscon.elite.service.NoContentException(String.format(message, args));
    }

    public NoContentException(String message) {
        super(message);
    }

    @Override
    public net.syscon.elite.service.NoContentException get() {
        return new net.syscon.elite.service.NoContentException(getMessage());
    }

    @Override
    public synchronized Throwable fillInStackTrace() {
        return this;
    }
}
