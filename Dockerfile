FROM node:18-alpine

EXPOSE 3000

WORKDIR /app
COPY . .

ENV NODE_ENV=production
RUN corepack enable

RUN pnpm install --prod
# Remove CLI packages since we don't need them in production by default.
# Remove this line if you want to run CLI commands in your container.
RUN rm -rf node_modules/@shopify/app node_modules/@shopify/cli
RUN pnpm run build

# You'll probably want to remove this in production, it's here to make it easier to test things!
RUN rm -f prisma/dev.sqlite

CMD ["pnpm", "run", "docker-start"]
