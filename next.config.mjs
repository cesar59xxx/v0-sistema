/** @type {import('next').NextConfig} */
const nextConfig = {
  reactCompiler: false, // Desabilitado React Compiler para compatibilidade
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  images: {
    unoptimized: true,
  },
  poweredByHeader: false,
  compress: true,
}

export default nextConfig
