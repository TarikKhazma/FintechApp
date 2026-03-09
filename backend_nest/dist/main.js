"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const core_1 = require("@nestjs/core");
const common_1 = require("@nestjs/common");
const app_module_1 = require("./app.module");
async function bootstrap() {
    const app = await core_1.NestFactory.create(app_module_1.AppModule);
    app.enableCors({ origin: '*' });
    app.useGlobalPipes(new common_1.ValidationPipe({
        whitelist: true,
        exceptionFactory: (errors) => {
            const message = Object.values(errors[0].constraints)[0];
            return new common_1.BadRequestException({ message });
        },
    }));
    await app.listen(3000, '0.0.0.0');
    console.log('Server running on http://0.0.0.0:3000');
}
bootstrap();
//# sourceMappingURL=main.js.map