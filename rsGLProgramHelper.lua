rsGLProgramHelper = {}

rsGLProgramHelper.ShaderType_PositionTextureGray = 100
rsGLProgramHelper.ShaderType_PositionTextureBlur = 101
rsGLProgramHelper.ShaderType_PositionTextureBloom = 102
rsGLProgramHelper.ShaderType_PositionTextureFrozen = 103


function rsGLProgramHelper.loadGreyGLProgram()
    local glProgram = cc.GLProgram:create("res/shader/grey.vsh","res/shader/grey.fsh")
    glProgram:link()
    glProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureGray)
end

function rsGLProgramHelper.reloadGreyGLProgram(glProgram)
    glProgram:initWithFilenames("res/shader/grey.vsh","res/shader/grey.fsh")
    glProgram:link()
    glProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureGray)
end

function rsGLProgramHelper.loadBlurGLProgram()
    local glProgram = cc.GLProgram:create("res/shader/blur.vsh","res/shader/blur.fsh")
    glProgram:link()
    glProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureBlur)
end

function rsGLProgramHelper.reloadBlurGLProgram(glProgram)
    glProgram:initWithFilenames("res/shader/blur.vsh","res/shader/blur.fsh")  
    glProgram:link()
    glProgram:updateUniforms()  
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureBlur)
end

function rsGLProgramHelper.loadBloomGLProgram()
    local glProgram = cc.GLProgram:create("res/shader/bloom.vsh","res/shader/bloom.fsh")
    glProgram:link()
    glProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureBloom)
end

function rsGLProgramHelper.reloadBloomGLProgram(glProgram)
    glProgram:initWithFilenames("res/shader/bloom.vsh","res/shader/bloom.fsh")  
    glProgram:link()
    glProgram:updateUniforms()  
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureBloom)
end

function rsGLProgramHelper.loadFrozenGLProgram()
    local glProgram = cc.GLProgram:create("res/shader/FrozenShader.vsh","res/shader/FrozenShader.fsh")
    glProgram:link()
    glProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureFrozen)
end

function rsGLProgramHelper.reloadFrozenGLProgram(glProgram)
    glProgram:initWithFilenames("res/shader/FrozenShader.vsh","res/shader/FrozenShader.fsh")    
    glProgram:link()
    glProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(glProgram,rsGLProgramHelper.ShaderType_PositionTextureFrozen)
end


function rsGLProgramHelper.loadCustomGLPrograms()
    rsGLProgramHelper.loadGreyGLProgram()   
    rsGLProgramHelper.loadBlurGLProgram() 
    rsGLProgramHelper.loadFrozenGLProgram()
--    rsGLProgramHelper.loadBloomGLProgram()
end

function rsGLProgramHelper.reloadCustomGLPrograms()
    -- 灰色
    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureGray)
    if p then
        p:reset()
        rsGLProgramHelper.reloadGreyGLProgram(p)
    end
    -- 模糊
    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureBlur)
    if p then
        p:reset()
        rsGLProgramHelper.reloadGreyGLProgram(p)
    end
    --结冰
    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureFrozen)
    if p then
        p:reset()
        rsGLProgramHelper.reloadGreyGLProgram(p)
    end
--    --高亮
--    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureBloom)
--    if p then
--        p:reset()
--        rsGLProgramHelper.reloadBloomGLProgram(p)
--    end
       
end

function rsGLProgramHelper.addColorGrey(sprite)
    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureGray)
    if p then 
--       p = cc.GLProgramState:getOrCreateWithGLProgram(p)
--       sprite:setGLProgramState(p)
        sprite:setGLProgram(p)
--        sprite:getGLProgram():link()
--        sprite:getGLProgram():updateUniforms()
    end
end

function rsGLProgramHelper.removeColorGrey(sprite)
    local p = cc.GLProgramState:getOrCreateWithGLProgramName("ShaderPositionTextureColor_noMVP")
    sprite:setGLProgramState(p)
end

function rsGLProgramHelper.addBlur(sprite)
    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureBlur)
    if p then 
        local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(p) 
        sprite:setGLProgramState(glProgramState)
        local size = sprite:getTexture():getContentSizeInPixels()
        glProgramState:setUniformVec2("blurSize",cc.p(1/size.width,1/size.height))
    end
end

function rsGLProgramHelper.removeBlur(sprite)
    local p = cc.GLProgramCache:getInstance():getGLProgram(cc.SHADER_POSITION_TEXTURE_COLOR)
    sprite:setGLProgram(p)
end

function rsGLProgramHelper.addFrozen(sprite)
    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureFrozen)
    if p then 
        
        local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(p) 
        sprite:setGLProgramState(glProgramState)
        local texture = sprite:getTexture()
        glProgramState:setUniformTexture("u_texture",texture)
    end
end

function rsGLProgramHelper.removeFrozen(sprite)
    local p = cc.GLProgramCache:getInstance():getGLProgram(cc.SHADER_POSITION_TEXTURE_COLOR)
    sprite:setGLProgram(p)
end

--function rsGLProgramHelper.addBloom(sprite)
--    local p = cc.GLProgramCache:getInstance():getGLProgram(rsGLProgramHelper.ShaderType_PositionTextureBloom)
--    if p then 
--        local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(p) 
--        sprite:setGLProgramState(glProgramState)
--        local texture = sprite:getTexture()
--        glProgramState:setUniformTexture("u_texture",texture)
--    end
--end
--
--function rsGLProgramHelper.removeBloom(sprite)
--    local p = cc.GLProgramCache:getInstance():getGLProgram(cc.SHADER_POSITION_TEXTURE_COLOR)
--    sprite:setGLProgram(p)
--end